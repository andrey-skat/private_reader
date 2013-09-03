require 'spec_helper'

require_relative '../../app/controllers/feeds_controller'

describe 'FeedsController' do

  describe 'POST /feeds' do

    let(:url) { 'http://example.com/' }

    it 'should add a feed' do
      post '/feeds', url: url

      expect(last_response.status).to eq 302
    end
  end

end