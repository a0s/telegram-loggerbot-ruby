lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'telegram/logger_bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'telegram-loggerbot-ruby'
  spec.version       = Telegram::LoggerBot::VERSION
  spec.authors       = ['Anton Osenenko']
  spec.email         = ['anton.osenenko@gmail.com']

  spec.summary       = "Telegram Logger Bot"
  spec.homepage      = 'https://github.com/a0s/telegram-loggerbot-ruby'
  spec.license = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_dependency 'telegram-bot-ruby'

  spec.add_development_dependency 'bundler', '~> 1.9'
end
