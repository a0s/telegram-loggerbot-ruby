require 'logger'
require 'telegram/bot'

require 'telegram/logger_bot/logger'
require 'telegram/logger_bot/logger_bot'
require 'telegram/logger_bot/version'
require 'telegram/logger_bot/configuration'

module Telegram
  module LoggerBot
    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
