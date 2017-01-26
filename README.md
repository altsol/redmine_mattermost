# Mattermost chat plugin for Redmine

This plugin posts updates to issues in your Redmine installation to a Mattermost
channel.

Redmine Supported versions: 2.0.x - 3.3.x.

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
Incoming WebHook integration in your Mattermost account and also set the Mattermost
Channel to the channel's handle (be careful, this is not the channel's display name
visible to users, you can find each channel's handle by navigating inside the channel
and clicking the down-arrow and selecting view info). See also the next two sections
for advanced and custom routing options.

## Customized Routing

You can also route messages to different channels on a per-project basis. To
do this, create a project custom field (Administration > Custom fields > Project)
named `Mattermost Channel`. If no custom channel is defined for a project, the parent
project will be checked (or the default will be used). To prevent all notifications
from being sent for a project, set the custom channel to `-`.

For more information, see http://www.redmine.org/projects/redmine/wiki/Plugins (see also next section for an easy configuration demonstration). 

## Screenshot Guided Configuration

Step 1: Create an Incoming Webhook in Mattermost (Account Settings > Integrations > Incoming Webhooks).

![step1](https://raw.githubusercontent.com/altsol/redmine_mattermost/assets/step1.png)

Step 2: Install this Redmine plugin for Mattermost.

![step2](https://raw.githubusercontent.com/altsol/redmine_mattermost/assets/step2.png)

Step 3: Configure this Redmine plugin for Mattermost. For per-project customized routing, leave the `Mattermost Channel` field empty and follow the next steps, otherwise all Redmine projects will post to the same Mattermost channel. Be careful when filling the channel field, you need to input the channel's handle, not the display name visible to users. You can find each channel's handle by going inside the channel and click the down-arrow and selecting view info.

![step3](https://raw.githubusercontent.com/altsol/redmine_mattermost/assets/step3.png)

Step 4: For per-project customized routing, first create the project custom field (Administration > Custom fields > Project).

![step4a](https://raw.githubusercontent.com/altsol/redmine_mattermost/assets/step4a.png)
![step4b](https://raw.githubusercontent.com/altsol/redmine_mattermost/assets/step4b.png)

Step 5: For per-project customized routing, configure the Mattermost channel handle inside your Redmine project.

![step5](https://raw.githubusercontent.com/altsol/redmine_mattermost/assets/step5.png)

## Credits

The source code is forked from https://github.com/sciyoshi/redmine-slack. Special thanks to the original author and contributors for making this awesome hook for Redmine. This fork is just refactored to use Mattermost-namespaced configuration options in order to use both hooks (Mattermost and Slack) in a Redmine installation.
