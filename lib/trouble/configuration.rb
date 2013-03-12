require 'logger'

module Trouble
  class Configuration
    attr_accessor :logger

    def initialize(options={})
      @logger = options[:logger] || default_logger
    end

    private

    def default_logger
      if defined?(Rails)
        Rails.logger
      else
        Logger.new(STDOUT)
      end
    end

  end
end

module Trouble

  # Public: Returns the the configuration instance.
  #
  def self.config
    @config ||= Configuration.new
  end

  # Public: Yields the configuration instance.
  #
  def self.configure(&block)
    yield config
  end

  # Public: Reset the configuration (useful for testing)
  #
  def self.reset!
    @config = nil
  end
end
