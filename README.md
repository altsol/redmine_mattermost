# Mattermost chat plugin for Redmine

This plugin posts updates to issues in your Redmine installation to a Mattermost
channel.
Redmine Supported versions: 2.0.x - 3.1.x.

## Screenshot

![screenshot](https://raw.githubusercontent.com/altsol/redmine_mattermost/assets/screenshot.png)

## Installation

From your Redmine plugins directory, clone this repository as `redmine_mattermost` (note
the underscore!):

    git clone https://github.com/altsol/redmine_mattermost.git redmine_mattermost

You will also need the `httpclient` dependency, which can be installed by running

    bundle install

from the plugin directory.

Restart Redmine, and you should see the plugin show up in the Plugins page.
Under the configuration options, set the Mattermost API URL to the URL for an
Incoming WebHook integration in your Mattermost account.

## Customized Routing

You can also route messages to different channels on a per-project basis. To
do this, create a project custom field (Administration > Custom fields > Project)
named `Mattermost Channel`. If no custom channel is defined for a project, the parent
project will be checked (or the default will be used). To prevent all notifications
from being sent for a project, set the custom channel to `-`.

For more information, see http://www.redmine.org/projects/redmine/wiki/Plugins.

## Credits

The source code is forked from https://github.com/sciyoshi/redmine-slack. Special thanks to the original author and contributors for making this awesome hook for Redmine. This fork is just refactored to use Mattermost-namespaced configuration options in order to use both hooks (Mattermost and Slack) in a Redmine installation.
