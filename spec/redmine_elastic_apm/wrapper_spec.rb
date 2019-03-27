require 'rails_helper'

module RedmineElasticAPM
  RSpec.describe Wrapper do
    context 'Rails application has already booted' do
      let(:app) { RedmineApp::Application.instance }
      let(:config_file) { File.expand_path('../fixtures/elastic_apm.yml', File.dirname(__FILE__)) }

      describe '.boot' do
        it 'starts the agent with a custom configuration' do
          RedmineElasticAPM::Wrapper.boot(app, config_file_path: config_file)

          expect(ElasticAPM.agent.config.server_url).to eq('somewhere-config.com')
        end
      end
    end
  end
end
