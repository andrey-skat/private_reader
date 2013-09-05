require_relative '../models/feed'
require_relative '../../lib/feed_discovery'

class PrivateReader < Sinatra::Base

  post '/feeds' do
    begin
      feed_data = FeedDiscovery.feed_data params[:url]
      feed = Feed.create!(feed_data)
      redirect to "/feeds/#{feed.id}"
    rescue FeedDiscovery::DiscoveryError
      { error: 'Feed not exist or not valid.' }.to_json
    rescue => e
      { error: "Can't add feed. #{e.message}" }.to_json
    end
  end

end