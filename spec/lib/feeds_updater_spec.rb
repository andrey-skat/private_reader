require 'spec_helper'

require_relative '../../lib/feeds_updater'

describe FeedsUpdater do

  before do
    FactoryGirl.create_list(:channel, 3)

    #builds 1 feed with 3 articles each
    feed = FeedFactory.build
    allow(FeedFetcher).to receive(:fetch).and_return(feed)
  end

  describe '.update_all' do

    it 'downloads new articles for channels' do
      expect(FeedFetcher).to receive(:fetch).exactly(3).times

      FeedsUpdater.update_all
    end

    it 'saves downloaded articles' do
      expect(Article.count).to eq 0
      FeedsUpdater.update_all
      expect(Article.count).to eq 3 # 1 feeds with 3 articles each
    end

    it 'saves last feed update time' do
      feed = FeedFactory.build
      feed[:last_updated] = Time.now.utc + 1.day
      allow(FeedFetcher).to receive(:fetch).and_return(feed)

      FeedsUpdater.update_all

      expect(Channel.first.last_updated.to_s).to eq feed[:last_updated].to_s
    end

    context 'nothing downloaded' do

    end
  end

end