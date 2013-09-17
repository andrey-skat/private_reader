class FeedDiscovery
  class DiscoveryError < StandardError; end

  def self.feed_data(url)
    feed = Feedzirra::Feed.fetch_and_parse url, user_agent: 'PrivateReader'
    transform_feed_data(feed)
  rescue
    raise DiscoveryError
  end

  def self.transform_feed_data(feed)
    {
        name: feed.title,
        url: feed.feed_url,
        last_modified: feed.last_modified
    }
  end
end