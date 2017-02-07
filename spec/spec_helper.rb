$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "telegram/loggerbot"
require "pp"

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    # mocks.verify_doubled_constant_names = true
    mocks.verify_partial_doubles = true
  end
end
