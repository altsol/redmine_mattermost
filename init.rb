require 'redmine'

require_dependency 'redmine_mattermost/listener'

Redmine::Plugin.register :redmine_mattermost do
	name 'Redmine Mattermost'
	author 'AltSol'
	url 'https://github.com/altsol/redmine_mattermost'
	author_url 'http://altsol.gr'
	description 'Mattermost chat integration'
	version '0.1'

	requires_redmine :version_or_higher => '0.8.0'

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
