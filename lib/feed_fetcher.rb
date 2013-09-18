
class FeedFetcher

  class DiscoveryError < StandardError; end

  class << self

    def discover(url)
      fetch(url)
    rescue
      raise DiscoveryError
    end

    def fetch(url)
      feed = Feedzirra::Feed.fetch_and_parse url, user_agent: 'PrivateReader'
      {
          name: feed.title,
          url: feed.feed_url || url,
          last_updated: get_last_modified(feed),
          entries: parse_entries(feed.entries)
      }
    end

    private

    # gets last modified date for feed
    # if it's not exist in a feed data,
    # trying to retrieve it from entries
    # else returns current datetime
    def get_last_modified(feed)
			#assume, that first entry is newest
			feed.last_modified || (feed.entries[0] && feed.entries[0].published) || Time.now
		end

    def parse_entries(items)
      return [] unless items.is_a?(Array)
      items.inject([]) do |memo, item|
        memo << {
          title: item.title,
          published: item.published,
          url: item.url,
          body: item.summary
        }
        memo
      end
    end

  end

end