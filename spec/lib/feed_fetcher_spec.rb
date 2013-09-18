require 'spec_helper'

require_relative '../../lib/feed_fetcher'

describe FeedFetcher do

  let(:url) { 'http://example.domain' }

  describe '.discover' do

    it 'calls .fetch' do
      expect(described_class).to receive(:fetch).with(url).once

      described_class.discover(url)
    end

    it 'raise error if feed not found' do
      expect { described_class.discover(url) }.to raise_error
    end

  end

  describe '.fetch' do

    it 'returns feed data' do
      feed = double(
          title: 'name_1',
          feed_url: url,
          last_modified: Time.now,
          entries: []
      )
      expect(Feedzirra::Feed).to receive(:fetch_and_parse).and_return(feed)
      result = described_class.fetch(url)

      expected_result = {
          name: feed.title,
          url: feed.feed_url,
          last_updated: feed.last_modified,
          entries: []
      }
      expect(result).to eq expected_result
    end

    context 'last last_modified date is nil' do

      it 'calculates last_modified date by entries' do
        feed = double(
            title: 'name_1',
            feed_url: url,
            last_modified: nil,
            entries: FeedzirraEntryFactory.build_list(3)
        )
        expect(Feedzirra::Feed).to receive(:fetch_and_parse).and_return(feed)
        result = described_class.fetch(url)

        expect(result[:last_updated]).to eq feed.entries[0].published
      end

      it 'last_modified is current date if haven`t entries' do
        feed = double(
            title: 'name_1',
            feed_url: url,
            last_modified: nil,
            entries: []
        )
        Time.stub(:now).and_return(Time.now)
        expect(Feedzirra::Feed).to receive(:fetch_and_parse).and_return(feed)
        result = described_class.fetch(url)

        expect(result[:last_updated]).to eq Time.now
      end

    end

  end

end