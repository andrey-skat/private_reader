require 'spec_helper'

require_relative '../../app/controllers/feeds_controller'

describe 'FeedsController' do

  describe 'POST /feeds' do

    let(:url) { 'http://example.com/' }

    it 'add a feed' do
      feed = {
          'name' => 'name_1',
          'url' => url
      }
      expect(FeedDiscovery).to receive(:feed_data).with(url).and_return(feed)

      post '/feeds', url: url

      created_feed = Feed.first
      #expect(created_feed.attributes).to include feed
      expect(last_response).to be_redirect
      expect(last_response.location).to include "/feeds/#{created_feed.id}"
    end

    it 'returns error message if cant create record' do
      expect(FeedDiscovery).to receive(:feed_data).and_return(nil)

      post '/feeds', url: url

      expect(JSON.parse last_response.body).to include 'error'
    end
  end

end