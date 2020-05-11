module RedmineAmazonChime
	class IssueMessageBuilder
		def initialize(context)
			@issue = context[:issue]
			@is_private = @issue.is_private
			@journal = context[:journal] rescue nil
			@msg_list = []
		end

		def build()
			# return empty list if issue is private.
			if is_private_issue
				Rails.logger.warn("Issue ##{@issue.id} #{escape(@issue.subject)} is private")
				return @msg_list
			end

			# if not @journal, it means it's a new issue.
			if not @journal
				@msg_list
				.append("[#{escape(@issue.project)}] #{escape(@issue.author)} created #{object_url(@issue)} #{escape(@issue.subject)}")
				.append("priority: #{escape(@issue.priority)}")
				.append("assinged to: #{escape(@issue.assinged_to) rescue ''}")
				.append("due date: #{@issue.due_date rescue ''}")
				.append("description: #{escape(@issue.description) rescue ''}")
			end

			# if @journal, and if its'not private, it means it's an update.
			if @journal and not is_private_journal
				@msg_list
				.append("[#{escape(@issue.project)}] #{escape(@journal.user.to_s)} updated #{object_url(@issue)} #{escape(@issue.subject)}")
				.append("notes: #{escape(@journal.notes)}")

				update_details = @journal.details.map { |d| detail_to_field(d) }
				update_details.each{ |u| @msg_list.append("#{escape(u[:title].to_s)}: #{escape(u[:value].to_s)}")}
			end

			# if @journal but if it's private, we won't post it.

			return @msg_list.join("\n")
		end

	private
		def is_private_issue()
			return @issue.is_private
		end

		def is_private_journal()
			if @journal
				return @journal.private_notes
			end
			return false
		end
		def escape(msg)
			msg.to_s.gsub("&", "&amp;").gsub("<", "&lt;").gsub(">", "&gt;")
		end

		def object_url(obj)
			if Setting.host_name.to_s =~ /\A(https?\:\/\/)?(.+?)(\:(\d+))?(\/.+)?\z/i
				host, port, prefix = $2, $4, $5
				Rails.application.routes.url_for(obj.event_url({:host => host, :protocol => Setting.protocol, :port => port, :script_name => prefix}))
			else
				Rails.application.routes.url_for(obj.event_url({:host => Setting.host_name, :protocol => Setting.protocol}))
			end
		end

		def detail_to_field(detail)
			field_format = nil

			if detail.property == "cf"
				key = CustomField.find(detail.prop_key).name rescue nil
				title = key
				field_format = CustomField.find(detail.prop_key).field_format rescue nil
			elsif detail.property == "attachment"
				key = "attachment"
				title = I18n.t :label_attachment
			else
				key = detail.prop_key.to_s.sub("_id", "")
				title = I18n.t "field_#{key}"
			end

			short = true
			value = escape(detail.value.to_s)

			case key
			when "title", "subject", "description"
				short = false
			when "tracker"
				tracker = Tracker.find(detail.value) rescue nil
				value = escape(tracker.to_s)
			when "project"
				project = Project.find(detail.value) rescue nil
				value = escape(project.to_s)
			when "status"
				status = IssueStatus.find(detail.value) rescue nil
				value = escape(status.to_s)
			when "priority"
				priority = IssuePriority.find(detail.value) rescue nil
				value = escape(priority.to_s)
			when "category"
				category = IssueCategory.find(detail.value) rescue nil
				value = escape(category.to_s)
			when "assigned_to"
				user = User.find(detail.value) rescue nil
				value = escape(user.to_s)
			when "fixed_version"
				version = Version.find(detail.value) rescue nil
				value = escape(version.to_s)
			when "attachment"
				attachment = Attachment.find(detail.prop_key) rescue nil
				value = escape(attachment.filename) if attachment
			when "parent"
				issue = Issue.find(detail.value) rescue nil
				value = "<#{object_url(issue)}|#{escape(issue)}>" if issue
			end

			case field_format
			when "version"
				version = Version.find(detail.value) rescue nil
				value = escape(version.to_s)
			end

			value = "-" if value.empty?

			result = { :title => title, :value => value }
			result[:short] = true if short
			result
		end
	end
end