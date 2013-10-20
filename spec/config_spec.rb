require 'minitest/autorun'
require 'feed_notifier'

describe FeedNotifier::Config do

  it 'excute configure block in config file' do
    config = FeedNotifier::Config.load("#{File.dirname(__FILE__)}/config_files/sample_config.rb")

    config.feed_urls.size.must_equal 1
  end

end
