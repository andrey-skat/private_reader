require_relative '../models/channel'
require_relative '../../lib/feed_fetcher'

class PrivateReader < Sinatra::Base

  get '/channels' do
    Rabl.render Channel.all, 'channels/list'
  end

  get '/channels/:id' do
    feed = Channel.find(params[:id])
    Rabl.render feed, 'channels/show'
  end

  post '/channels/update' do
	  {}
  end

  post '/channels' do
    begin
			feed = Channel.subscribe params[:url]
      redirect to "/channels/#{feed.id}"
    rescue => e
      { error: "Can't add feed. #{e.message}" }.to_json
    end
  end

end