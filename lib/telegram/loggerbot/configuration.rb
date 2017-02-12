module Telegram
  module LoggerBot
    class Configuration
      attr_accessor :token, :chat_id, :level, :next_logger, :api, :enabled
    end
  end
end
