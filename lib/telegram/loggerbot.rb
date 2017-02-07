require 'logger'
require 'telegram/bot'

require 'telegram/loggerbot/logger'
require 'telegram/loggerbot/loggerbot'
require 'telegram/loggerbot/version'
require 'telegram/loggerbot/configuration'

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
