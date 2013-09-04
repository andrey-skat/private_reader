require 'spec_helper'

require_relative '../../app/controllers/feeds_controller'

describe 'FeedsController' do

  describe 'POST /feeds' do

    let(:url) { 'http://example.com/' }

    it 'add a feed' do
      feed = {
          'name' => 'name_1',
          'url'=> url
      }
      expect(FeedDiscovery).to receive(:feed_data).with(url).and_return(feed)

      post '/feeds', url: url

      expect(Feed.first.attributes).to include feed
      expect(last_response.status).to eq 302
    end
  end

end