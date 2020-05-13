module RedmineAmazonChime
	class AmazonChimeListener < Redmine::Hook::Listener
		def redmine_amazon_chime_issues_new_after_save(context={})
			chime_webhook = chime_webhook_for_project(context[:issue].project)
			if chime_webhook.present?
				chime_message = ChimeMessage.new(context, chime_webhook)
				chime_message.send()
			end
		end

		def redmine_amazon_chime_issues_edit_after_save(context={})
			chime_webhook = chime_webhook_for_project(context[:issue].project)
			if chime_webhook.present?
				chime_message = ChimeMessage.new(context, chime_webhook)
				chime_message.send()
			end
		end

		# [TODO] Not sure when this method is called.
=begin
		def model_changeset_scan_commit_for_issue_ids_pre_issue_update(context={})
			issue = context[:issue]
			journal = issue.current_journal
			changeset = context[:changeset]
			chime_webhook = chime_webhook_for_project(issue.project)

			return unless chime_webhook.present? and issue.save
			return if issue.is_private?

			msg = "[#{escape issue.project}] #{escape journal.user.to_s} updated #{object_url issue}|#{escape issue}"

			repository = changeset.repository

			if Setting.host_name.to_s =~ /\A(https?\:\/\/)?(.+?)(\:(\d+))?(\/.+)?\z/i
				host, port, prefix = $2, $4, $5
				revision_url = Rails.application.routes.url_for(
					:controller => 'repositories',
					:action => 'revision',
					:id => repository.project,
					:repository_id => repository.identifier_param,
					:rev => changeset.revision,
					:host => host,
					:protocol => Setting.protocol,
					:port => port,
					:script_name => prefix
				)
			else
				revision_url = Rails.application.routes.url_for(
					:controller => 'repositories',
					:action => 'revision',
					:id => repository.project,
					:repository_id => repository.identifier_param,
					:rev => changeset.revision,
					:host => Setting.host_name,
					:protocol => Setting.protocol
				)
			end

			attachment = {}
			attachment[:text] = ll(Setting.default_language, :text_status_changed_by_changeset, "<#{revision_url}|#{escape changeset.comments}>")
			attachment[:fields] = journal.details.map { |d| detail_to_field d }

			speak msg, chime_webhook, attachment
		end
=end

	private
		def chime_webhook_for_project(proj)
			return nil if proj.blank?

			cf = ProjectCustomField.find_by_name("Chime Webhook")
			val = proj.custom_value_for(cf).value rescue nil

			# Channel name '-' or empty '' is reserved for NOT notifying
			return nil if val.to_s == ''
			return nil if val.to_s == '-'
			return val if val.is_a? String
			val
		end
	end
end