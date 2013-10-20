require 'minitest/autorun'
require 'feed_notifier'

describe 'feed update' do

  def load_sample
    xml = File.read("#{File.dirname(__FILE__)}/feeds/gitlab_sample.xml")
    Feedzirra::Feed.parse(xml)
  end

  it 'returns updated feeds' do
    feed_sample = load_sample

    old_feeds = []
    feed_sample.entries.each_with_index do |entry,index|
      old_feeds << entry unless index == 0
    end

    feed_sample_minus = feed_sample.clone
    feed_sample_minus.entries = old_feeds

    config = FeedNotifier::Config.new()
    feed_list = FeedNotifier::FeedList.new(config)
    feed_list.instance_variable_set :@last_feeds, { :sample => feed_sample_minus }

    Feedzirra::Feed.stub(:fetch_and_parse,{ :sample => feed_sample }) do
      entries = feed_list.updated_entries

      entries.size.must_equal 1
      entries.first.title.must_equal 'John Smith pushed to branch master at Sandbox / Charts.js'
    end
  end

end

