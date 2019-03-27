module RedmineElasticAPM
  class Config
    CONFIG_FILE = File.expand_path('../config/elastic_apm.yml', File.dirname(__FILE__)).freeze
  end
  class << self
    def boot(app)
      stop

      return unless should_start?

      apm_config = config_from(app)
      start(apm_config)
    end

    private

    def stop
      ElasticAPM.stop
    end

    def start(config)
      ElasticAPM.start(config).tap do |agent|
        agent.instrumenter.subscriber = ElasticAPM::Subscriber.new(agent) if agent
      end
    end

    def config_from(app)
      app.config.elastic_apm = ActiveSupport::OrderedOptions.new

      ElasticAPM::Config::DEFAULTS.each { |option, value| app.config.elastic_apm[option] = value }

      app.config.elastic_apm.config_file = Config::CONFIG_FILE

      ElasticAPM::Config.new(app.config.elastic_apm.merge(app: app)).tap do |c|
        c.log_path = Rails.root.join(c.log_path) if c.log_path && !c.log_path.start_with?('/')
      end
    end

    def should_start?
      config_file_exists? &&
        !Rails.const_defined?(:Console) &&
        !ElasticAPM.running?
    end

    def config_file_exists?
      File.exist?(Config::CONFIG_FILE)
    end
  end
end

RedmineApp::Application.configure do
  RedmineElasticAPM.boot(self)
end
