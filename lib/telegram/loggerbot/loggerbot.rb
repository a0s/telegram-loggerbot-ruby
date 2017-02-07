module Telegram
  module LoggerBot
    def self.new(args = {})
      Telegram::LoggerBot::Logger.new(args)
    end
  end
end
