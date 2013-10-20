require "feed_notifier/version"
require 'feed_notifier/config'
require 'feed_notifier/feed'
require 'feed_notifier/runner'
require 'logger'

module FeedNotifier
  class <<self
    attr_accessor :logger
  end
end
FeedNotifier.logger = Logger.new(STDOUT)
FeedNotifier.logger.level = Logger::INFO
