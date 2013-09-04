require_relative '../models/feed'
require_relative '../../lib/feed_discovery'

class PrivateReader < Sinatra::Base

  post '/feeds' do
    feed_data = FeedDiscovery.feed_data params[:url]
    feed = Feed.create(feed_data)

    if feed
      [302]
    else
      {
          error: "Can't add feed"
      }.to_json
    end
  end

end