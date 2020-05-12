# Amazon Chime plugin for Redmine

This plugin posts updates to issues in your Redmine installation to an Amazon Chime Chat Room.<br>
Redmine Supported versions: 2.0.x - 3.3.x.

## Installation

1. From your Redmine plugins directory, clone this repository as `redmine_amazon_chime` (note the underscore!):
   ```shell
   git clone https://github.com/tsz662/redmine_amazon_chime.git
   ```
1. You will also need the `httpclient` dependency, which can be installed by running from the plugin directory.
   ```shell
   bundle install
   ```
1. Restart Redmine.

## Configuration

1. Right-click your chat room and select Manage Webhooks.
1. Click `Add webhook` to add a webhook and click `Copy URL`.
1. Install this Redmine plugin.
1. Ask Redmine Administrator to create a project custom field `Chime Webhook`.
1. Go to your Redmine project settings page and paste the webhook URL in the `Chime Webhook` project custom field.

## Credits

The source code is forked from https://github.com/altsol/redmine_mattermost. Special thanks to the original author and contributors for making this awesome hook for Redmine. This fork is just refactored to use Amazon Chime in a Redmine installation.
