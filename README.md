# redmine_elastic_apm

A redmine plugin to integrate the elastic_apm gem without the need to make changes to redmine repository itself

## Installation

- Clone this plugin into the redmine `plugins` folder
- Run `bundle install`
- Create the `elastic_apm.yml` in this plugin `config` folder
- Restart Redmine

## Compatibility

This plugin **prepends** the `ApplicationController#user_setup` method in order to provide Redmine current user to elastic. For this reason, it is incompatible with any other plugin which patches `ApplicationController#user_setup` using `alias_method` or `alias_method_chain`. A quick fix is to comment `require 'redmine_elastic_apm/patches/application_controller_patch'` in `lib/redmine_elastic_apm.rb`