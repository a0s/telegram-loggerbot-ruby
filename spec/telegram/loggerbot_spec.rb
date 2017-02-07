require "spec_helper"

describe Telegram::LoggerBot do
  it "has a version number" do
    expect(Telegram::LoggerBot::VERSION).not_to be nil
  end
end
