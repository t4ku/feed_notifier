require 'feedzirra'
require 'terminal-notifier'

module FeedNotifier
  class FeedList

    def initialize(config)
      @config = config
    end

    def urls
      @urls ||= @config.feed_urls
    end

    def updated_entries(since={})
      unless (@last_feeds && @last_feeds.size > 0)
        FeedNotifier.logger.info "fetching urls for the first time.."
        @last_feeds = Feedzirra::Feed.fetch_and_parse(urls)
        return []
      end

      new_feeds = Feedzirra::Feed.fetch_and_parse(urls)

      new_entries = new_feeds.inject([]) { |entries,(url,feed)|
        last_feed = @last_feeds[url]
        if last_feed
          unless last_feed.respond_to?(:feed_url)
            FeedNotifier.logger.warn "feed object for #{url} isn't valid. #{last_feed}"
            next entries
          end

          last_feed.update_from_feed(feed)
          FeedNotifier.logger.debug "updates for #{url} ... #{last_feed.new_entries}"
          next entries + last_feed.new_entries
        end
        entries
      }

      @last_feeds = new_feeds
      return new_entries
    end
  end


  class Notifier
    def self.notify(entry)
      TerminalNotifier.notify(entry.title)
    end
  end
end
