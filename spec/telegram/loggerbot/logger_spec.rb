require "spec_helper"

describe Telegram::LoggerBot::Logger do
  subject { Telegram::LoggerBot::Logger }

  def pass_levels
    # logger.level / msg.level
    #          :debug :info :warn :error :fatal
    {:debug => [true, true, true, true, true],
     :info => [false, true, true, true, true],
     :warn => [false, false, true, true, true],
     :error => [false, false, false, true, true],
     :fatal => [false, false, false, false, true]}
  end

  def constantized_levels
    {debug: Logger::DEBUG,
     info: Logger::INFO,
     warn: Logger::WARN,
     error: Logger::ERROR,
     fatal: Logger::FATAL}
  end

  it "should not create without token" do
    expect { subject.new(chat_id: 123) }.to raise_error(Telegram::LoggerBot::TokenMissed)
  end

  it "should not create without chat_id" do
    expect { subject.new(token: 't0kEn') }.to raise_error(Telegram::LoggerBot::ChatIdMissed)
  end

  describe 'simple logging' do
    before :all do
      @kls_fake_telegram = Class.new
      @kls_fake_telegram.send :define_method, :send_message, Proc.new { |args|}
      @obj_fake_telegram = @kls_fake_telegram.new
    end

    describe 'default logger level is DEBUG' do
      [:debug, :info, :warn, :error, :fatal].each do |msg_level|
        it "message for '#{msg_level}' should include text #{msg_level.to_s.upcase}" do
          expect(@obj_fake_telegram).to receive(:send_message).ordered.with(hash_including(text: /#{msg_level.to_s.upcase}/))
          expect(@obj_fake_telegram).to receive(:send_message).ordered.with(hash_including(text: 'ABCD'))
          subject.new(api: @obj_fake_telegram, token: 't0kEn', chat_id: 123).send msg_level, 'ABCD'
        end
      end
    end

    [:debug, :info, :warn, :error, :fatal].each do |logger_level|
      context "when logger.level=#{logger_level.to_s.upcase}" do
        [:debug, :info, :warn, :error, :fatal].each_with_index do |msg_level, msg_index|
          context "when message.level=#{msg_level.to_s.upcase}" do
            it do
              if pass_levels[logger_level][msg_index]
                expect(@obj_fake_telegram).to receive(:send_message).ordered.with(hash_including(text: /#{msg_level.to_s.upcase}/))
                expect(@obj_fake_telegram).to receive(:send_message).ordered.with(hash_including(text: 'ABCD'))
                subject.new(api: @obj_fake_telegram, token: 't0kEn', chat_id: 123, level: constantized_levels[logger_level]).send msg_level, 'ABCD'
              else
                expect(@obj_fake_telegram).to_not receive(:send_message)
                subject.new(api: @obj_fake_telegram, token: 't0kEn', chat_id: 123, level: constantized_levels[logger_level]).send msg_level, 'ABCD'
              end
            end
          end
        end
      end
    end
  end

  describe 'chained loggers' do
    # TODO add specs for chained loggers
  end
end
