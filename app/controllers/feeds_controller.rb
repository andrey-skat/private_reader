require_relative '../models/feed'

class PrivateReader < Sinatra::Base

  post '/feeds' do
    feed = Feed.create(params)

    if feed
      [302]
    else
      {
          error: "Can't add feed"
      }.to_json
    end
  end

end