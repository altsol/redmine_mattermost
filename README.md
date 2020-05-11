# Amazon Chime plugin for Redmine

This plugin posts updates to issues in your Redmine installation to a Mattermost
channel.

Redmine Supported versions: 2.0.x - 3.3.x.

## Installation

From your Redmine plugins directory, clone this repository as `redmine_amazon_chime` (note
the underscore!):

    git clone https://github.com/tsz662/redmine_amazon_chime.git

You will also need the `httpclient` dependency, which can be installed by running

    bundle install

from the plugin directory.

## Configuration

1. Create an Incoming Webhook in your Amaon Chime chatroom.
1. Install this Redmine plugin.
1. Ask Redmine Administrator to create a project custom field "Chime Webhook".
1. Go to your Redmine project settings page and paste the Chime Webhook URL in the Chime Webhook project custom field.

## Credits

The source code is forked from https://github.com/altsol/redmine_mattermost. Special thanks to the original author and contributors for making this awesome hook for Redmine. This fork is just refactored to use Amazon Chime in a Redmine installation.
