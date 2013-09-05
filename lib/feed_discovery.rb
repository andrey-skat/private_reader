#require 'feedbag'
require 'feedzirra'

class FeedDiscovery
  class DiscoveryError < StandardError; end

  def self.feed_data(url)
    feed = Feedzirra::Feed.fetch_and_parse url, user_agent: 'PrivateReader'
    {
        name: feed.title,
        url: feed.feed_url || url
    }
  rescue
    raise DiscoveryError
  end
end