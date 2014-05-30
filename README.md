# puppet-slack

## Description

A Puppet report handler for sending notifications of puppet runs to
[Slack Messaging](https://slack.com).

## Installation & Usage

1. Install puppet-slack as a module in your Puppet master's module path.

1. You will need to create a Slack Incoming WebHooks integration at [slack.com](https://slack.com)

1. Add the class to the puppet master node:

         class { 'slack':
           slack_token          => 'INCOMING_WEBHOOK_TOKEN',
           slack_channel        => '#puppet',
           slack_botname        => 'puppet',
           slack_iconurl        => 'http://puppetlabs.com/wp-content/uploads/2010/12/PL_logo_vertical_RGB_lg.jpg',
           slack_puppet_reports => 'store,http,slack',
         }

1. Run the Puppet client and sync the report as a plugin

## Screenshot

![image](https://raw.githubusercontent.com/fsalum/puppet-slack/master/puppet-slack.png)

## Author

Felipe Salum <fsalum@gmail.com>

## Copyright and License

Copyright (C) 2012 Felipe Salum

Felipe Salum can be contacted at: fsalum@gmail.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
