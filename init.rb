require 'redmine'

require_dependency 'redmine_amazon_chime'

Redmine::Plugin.register :redmine_amazon_chime do
	name 'Redmine Amazon Chime'
	author 'tsz662'
	url 'https://github.com/tsz662/redmine_amazon_chime'
	description 'Amazon Chime integration'
	version '0.1'

	requires_redmine :version_or_higher => '2.0.0'
end

ActionDispatch::Callbacks.to_prepare do
	require_dependency 'issue'
	unless Issue.included_modules.include? RedmineAmazonChime::IssuePatch
		Issue.send(:include, RedmineAmazonChime::IssuePatch)
	end
end
