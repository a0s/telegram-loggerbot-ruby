module Telegram
  module LoggerBot
    class Logger < ::Logger
      def initialize(next_logger = nil, level = nil)
        @next_logger = next_logger
        @level = level || (next_logger.level if next_logger) || DEBUG
        @default_formatter = Formatter.new
        @api = Telegram::Bot::Api.new(Telegram::LoggerBot.configuration.token)
      end

      def clear_markdown(str)
        str.gsub(/[^a-zA-Z0-9\<\>\s\n:+-]/, '')
      end

      SEV_ICON = [
          "\xF0\x9F\x93\x98",
          "\xF0\x9F\x93\x94",
          "\xF0\x9F\x93\x99",
          "\xF0\x9F\x93\x95",
          "\xF0\x9F\x93\x9A",
          "\xF0\x9F\x93\x93"
      ].each(&:freeze).freeze

      def format_severity_icon(severity)
        SEV_ICON[severity] || "\xF0\x9F\x93\x93"
      end

      TIME_ICON_FIRST_HALF = [
          "\xF0\x9F\x95\x9B",
          "\xF0\x9F\x95\x90",
          "\xF0\x9F\x95\x91",
          "\xF0\x9F\x95\x92",
          "\xF0\x9F\x95\x93",
          "\xF0\x9F\x95\x94",
          "\xF0\x9F\x95\x95",
          "\xF0\x9F\x95\x96",
          "\xF0\x9F\x95\x97",
          "\xF0\x9F\x95\x98",
          "\xF0\x9F\x95\x99",
          "\xF0\x9F\x95\x9A"
      ]

      TIME_ICON_SECOND_HALF = [
          "\xF0\x9F\x95\xA7",
          "\xF0\x9F\x95\x9C",
          "\xF0\x9F\x95\x9D",
          "\xF0\x9F\x95\x9E",
          "\xF0\x9F\x95\x9F",
          "\xF0\x9F\x95\xA0",
          "\xF0\x9F\x95\xA1",
          "\xF0\x9F\x95\xA2",
          "\xF0\x9F\x95\xA3",
          "\xF0\x9F\x95\xA4",
          "\xF0\x9F\x95\xA5",
          "\xF0\x9F\x95\xA6"
      ]

      def format_time_icon(time)
        hour12 = time.strftime('%I').to_i
        hour12 = 0 if hour12 == 12
        minute = time.strftime('%M').to_i
        if minute < 30
          TIME_ICON_FIRST_HALF[hour12]
        else
          TIME_ICON_SECOND_HALF[hour12]
        end
      end

      def add(severity, message = nil, progname = nil, &block)
        severity ||= UNKNOWN
        return true if severity < @level
        if message.nil?
          if block_given?
            message = block.dup.call
          else
            message = progname
            progname = @progname
          end
        end

        chat_id = Telegram::LoggerBot.configuration.chat_id
        time = Time.now

        text = "#{format_severity_icon(severity)}*#{format_severity(severity)}*"
        text << "   _#{clear_markdown(progname)}_" if progname
        text << "\n#{format_time_icon(time)}#{time}"

        @api.send_message(chat_id: chat_id, text: text, parse_mode: 'Markdown')
        @api.send_message(chat_id: chat_id, text: message)

        return true unless @next_logger

        @next_logger.add(severity, message, progname, &block)
      end
    end
  end
end
