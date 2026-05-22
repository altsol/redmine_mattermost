require 'redmine'

lib_dir = File.expand_path('lib', __dir__)
Rails.autoloaders.each { |loader| loader.ignore(lib_dir) }

require_relative 'lib/redmine_mattermost/listener'
require_relative 'lib/redmine_mattermost/issue_patch'

Redmine::Plugin.register :redmine_mattermost do
	name 'Redmine Mattermost'
	author 'AltSol'
	url 'https://github.com/altsol/redmine_mattermost'
	author_url 'http://altsol.gr'
	description 'Mattermost chat integration'
	version '0.7'

	requires_redmine :version_or_higher => '5.0.0'

	settings \
		:default => {
			'callback_url' => 'http://example.com/callback/',
			'channel' => nil,
			'icon' => 'https://raw.githubusercontent.com/altsol/redmine_mattermost/assets/icon.png',
			'username' => 'redmine',
			'display_watchers' => 'no'
		},
		:partial => 'settings/mattermost_settings'
end

unless Issue.included_modules.include?(RedmineMattermost::IssuePatch)
	Issue.include(RedmineMattermost::IssuePatch)
end
