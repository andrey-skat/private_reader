require 'spec_helper'
require_relative '../../lib/feed_discovery'

describe FeedDiscovery do

  let (:url) { 'http://example.com/' }
  let (:feed) { double(title: 'name_1', feed_url: url) }

  it 'should get feed title' do
    expect(Feedzirra::Feed).to receive(:fetch_and_parse).and_return(feed)
    result = FeedDiscovery.feed_data(url)
    expect(result).to eq({
      name: 'name_1',
      url: url
    })
  end

end