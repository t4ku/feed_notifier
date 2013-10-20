# FeedNotifier

Ruby scripts to notify feed updates via Apple's Notification Center

## Installation

Add this line to your application's Gemfile:

    gem 'feed_notifier'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feed_notifier

## Usage

First, create config script like shown below.

```
FeedNotifier.configure do |config|
  # fetch interval
  config.interval = 60*1  # fetch every minute

  # feed urls
  config.feed_urls << 'https://news.google.com/news/feeds?hl=us&ned=us&ie=UTF-8&oe=UTF-8&output=rss'
end
```

Once the configuration is done, run command with -f option.

```
(bundle exec) feed_notifier -f feeds.rb
```

## Todo

* Option to run as daemon

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
