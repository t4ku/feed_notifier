FeedNotifier.configure do |config|
  # fetch interval
  config.interval = 60*1  # fetch every minute

  # feed urls
  config.feed_urls << 'https://news.google.com/news/feeds?hl=us&ned=us&ie=UTF-8&oe=UTF-8&output=rss'
end
