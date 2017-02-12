#Telegram::LoggerBot

[![Build Status](https://travis-ci.org/a0s/telegram-loggerbot-ruby.svg?branch=master)](https://travis-ci.org/a0s/telegram-loggerbot-ruby)

Telegram::LoggerBot allows to send event logs directly to the Telegram chat

![preview1](https://github.com/a0s/telegram-loggerbot-ruby/raw/master/img/preview1.jpg)![preview2](https://github.com/a0s/telegram-loggerbot-ruby/raw/master/img/preview2.jpg)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'telegram-loggerbot-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install telegram-loggerbot-ruby

##Usage

  1. Create new bot with @BotFather and get his TOKEN
  2. Write something to the new bot (!!!)
  3. Obtain your TELEGRAM_USER_ID from, for example, @get_id_bot

Require it to your code:

```ruby
require 'telegram/loggerbot'
```

Initialize with obtained TOKEN and TELEGRAM_USER_ID: 

```ruby
Telegram::LoggerBot.configure do |config|
    config.token = TOKEN                                 # required
    config.chat_id = USER_ID_OR_CHAT_ID                  # required
    config.enabled = false                               # optional, true by default
    config.level = Logger::INFO                          # optional, default is Logger::DEBUG
    config.next_logger = App.existing_logger_instance    # optional
    config.api = App.existing_telegram_bot_api_instance  # optional
end

logger = Telegram::LoggerBot.new
```

or in classic style:

```ruby
logger = Telegram::LoggerBot.new(
    token: TOKEN,                                 # required
    chat_id: USER_ID_OR_CHAT_ID,                  # required
    enabled: false,                               # optional, true by default
    level: Logger::INFO,                          # optional, default is Logger::DEBUG
    next_logger: App.existing_logger_instance,    # optional
    api: App.existing_telegram_bot_api_instance   # optional
)
```

You can pass events through LoggerBot to any other logger:

```ruby
existing_logger = Logger.new(STDOUT)
logger = Telegram::LoggerBot.new(..., next_logger: existing_logger)
``` 

Log you events:

```ruby
logger.debug('MyProgram') { "Text of some errors" }
logger.info('MyProgram') { "Text of some errors" }
logger.warn('MyProgram') { "Text of some errors" }
logger.error('MyProgram') { "Text of some errors" }
logger.fatal('MyProgram') { "Text of some errors" }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
