require 'redmine_elastic_apm' if defined?(ElasticAPM)

Redmine::Plugin.register :redmine_elastic_apm do
  name        'Redmine Elastic APM'
  author      'Stephane EVRARD'
  description 'A plugin to integrate Elastic APM reporting into Redmine'
  version     '0.0.1'
  url         'https://gitlab.akka.eu/akkakp/redmine_elastic_apm'
end
