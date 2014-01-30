require 'spec_helper'

require_relative '../../lib/feeds_updater'

describe FeedsUpdater do

  before do
    FactoryGirl.create_list(:channel, 3)

    #builds 3 feed with 1 article
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
      expect(Article.count).to eq 3 # 3 feed with 1 article each
    end

    it 'saves last feed update time' do
	    feed = FeedFactory.build
	    feed[:last_updated] = Time.now
	    allow(FeedFetcher).to receive(:fetch).and_return(feed)

	    #expect(Channel.first.last_updated.strftime("%Y-%m-%d %H:%M")).not_to eq feed[:last_updated].strftime("%Y-%m-%d %H:%M")
      FeedsUpdater.update_all

      expect(Channel.first.last_updated.strftime("%Y-%m-%d %H:%M")).to eq feed[:last_updated].strftime("%Y-%m-%d %H:%M")
    end

    context 'nothing downloaded' do

    end
  end

end