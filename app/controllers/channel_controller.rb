require_relative '../models/channel'
require_relative '../../lib/feed_discovery'

class PrivateReader < Sinatra::Base

  get '/channels' do
    Rabl.render Channel.all, 'channels/list'
  end

  get '/channels/:id' do
    feed = Channel.find(params[:id])
    Rabl.render feed, 'channels/show'
  end

  post '/channels' do
    begin
      feed_data = FeedDiscovery.feed_data params[:url]
      feed = Channel.create!(feed_data)
      redirect to "/channels/#{feed.id}"
    rescue FeedDiscovery::DiscoveryError
      { error: 'Feed not exist or not valid.' }.to_json
    rescue => e
      { error: "Can't add feed. #{e.message}" }.to_json
    end
  end

end