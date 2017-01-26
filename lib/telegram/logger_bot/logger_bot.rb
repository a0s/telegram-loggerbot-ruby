module Telegram
  module LoggerBot
    def self.new(obj = nil)
      case obj
        when ::Logger
          Telegram::LoggerBot::Logger.new(obj)
        when ::NilClass
          Telegram::LoggerBot::Logger.new
        else
          fail("Unknown type of next logger #{obj.inspect}")
      end
    end
  end
end
