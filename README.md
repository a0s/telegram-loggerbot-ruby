![preview1](https://github.com/a0s/telegram-loggerbot-ruby/raw/master/img/preview1.jpg)![preview2](https://github.com/a0s/telegram-loggerbot-ruby/raw/master/img/preview2.jpg)

#telegram-loggerbot-ruby

Allows to send event logs directly to the telegram chat

##Installation

Add following line to your Gemfile:

```ruby
gem 'telegram-loggerbot-ruby'
```

And then execute:

```
$ bundle
```

Or install it system-wide:

```
gem install telegram-loggerbot-ruby
```

##Usage

  1. Create new bot with @BotFather and get his TOKEN
  2. Write something to the new bot (!!!)
  3. Obtain your TELEGRAM_USER_ID from, for example, @get_id_bot

Require it to your code:

```ruby
require 'telegram/logger_bot'
```

Configure with obtained TOKEN and TELEGRAM_USER_ID: 

```ruby
Telegram::LoggerBot.configure do |config|
  config.token = 'TOKEN'
  config.chat_id = TELEGRAM_USER_ID
end
```

Create new logger:

```ruby
logger = Telegram::LoggerBot.new
```

You can pass events through LoggerBot to your standard logger:

```ruby
existing_logger = Logger.new(STDOUT)
logger = Telegram::LoggerBot.new(existing_logger)
``` 

Log you events:

```ruby
logger.debug('MyProgram') { "Text of some errors" }
logger.info('MyProgram') { "Text of some errors" }
logger.warn('MyProgram') { "Text of some errors" }
logger.error('MyProgram') { "Text of some errors" }
logger.fatal('MyProgram') { "Text of some errors" }
```

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request
