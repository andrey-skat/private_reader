require 'spec_helper'
require_relative '../../lib/feed_discovery'

describe FeedDiscovery do

  let (:url) { 'http://example.com/' }

  it 'gets channel title' do
    feed = double(title: 'name_1', feed_url: url, last_modified: Time.new.getutc)
    expect(Feedzirra::Feed).to receive(:fetch_and_parse).and_return(feed)
    result = FeedDiscovery.feed_data(url)

    expect(result).to eq({
      name: feed.title,
      url: feed.feed_url,
      last_modified: feed.last_modified
    })
  end

  xit 'calculates last_modified date by entries if not present in feed' do
    feed = double(title: 'name_1', feed_url: url)
  end

  it 'raise error if feed not found' do
    expect { FeedDiscovery.feed_data(url) }.to raise_error
  end

end