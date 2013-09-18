require 'spec_helper'

describe 'ChannelsController' do

  describe 'GET /channels' do
    before do
      FactoryGirl.create_list(:channel, 3)
    end

    it 'shows all channels' do
      get '/channels'

      channels = JSON.parse(last_response.body)
      expect(channels.count).to eq 3
      expect(channels[0]['name']).to eq 'name_1'
    end

    it 'content type must be application/json' do
      get '/channels'

      expect(last_response.content_type).to match(/application\/json/)
    end
  end

  describe 'GET /channels/:id' do
    it 'shows channel data' do
      FactoryGirl.create(:channel)

      get '/channels/1'

      expect(JSON.parse(last_response.body)).to include 'name'
      expect(JSON.parse(last_response.body)['name']).to eq 'name_1'
    end
  end

  describe 'POST /channels' do

    let(:url) { 'http://example.com/' }

    it 'adds a channel' do
      channel = {
          name: 'name_1',
          url: url
      }
      expect(FeedFetcher).to receive(:discover).with(url).and_return(channel)

      post '/channels', url: url

      created_channel = Channel.first
      #expect(created_channel.attributes).to include channel
      expect(last_response).to be_redirect
      expect(last_response.location).to include "/channels/#{created_channel.id}"
    end

    it 'returns error message if cant create record' do
      expect(FeedFetcher).to receive(:discover).and_return(nil)

      post '/channels', url: url

      expect(JSON.parse last_response.body).to include 'error'
    end
  end

end