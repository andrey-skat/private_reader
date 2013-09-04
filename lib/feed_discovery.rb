#require 'feedbag'
require 'feedzirra'

class FeedDiscovery
  def self.feed_data(url)
    feed = Feedzirra::Feed.fetch_and_parse url, user_agent: 'PrivateReader'
    {
        name: feed.title,
        url: feed.feed_url || url
    }
  rescue
    raise 'Error in load and parse feed'
  end
end