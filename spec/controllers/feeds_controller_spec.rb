require 'spec_helper'

describe 'FeedsController' do

  describe 'GET /feeds' do
    before do
      FactoryGirl.create_list(:feed, 3)
    end

    it 'shows all feeds' do
      get '/feeds'

      feeds = JSON.parse(last_response.body)
      expect(feeds.count).to eq 3
      expect(feeds[0]['name']).to eq 'name_1'
    end

    it 'content type must be application/json' do
      get '/feeds'

      expect(last_response.content_type).to match(/application\/json/)
    end
  end

  describe 'GET /feeds/:id' do
    it 'shows feed data' do
      FactoryGirl.create(:feed)

      get '/feeds/1'

      expect(JSON.parse(last_response.body)).to include 'name'
      expect(JSON.parse(last_response.body)['name']).to eq 'name_1'
    end
  end

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