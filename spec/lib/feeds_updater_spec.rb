require 'spec_helper'

require_relative '../../lib/feeds_updater'

describe FeedsUpdater do

  before do
    FactoryGirl.create_list(:channel, 3)

    #builds 1 feed with 1 article
    feed = FeedFactory.build
    FeedFetcher.stub(:fetch).and_return(feed)
  end

  describe '.update_all' do

    it 'downloads new articles for channels' do
      expect(FeedFetcher).to receive(:fetch).exactly(3).times

      FeedsUpdater.update_all
    end

    it 'saves downloaded articles' do
      expect(Article.count).to eq 0
      FeedsUpdater.update_all
      expect(Article.count).to eq 3 # 1 feed with 3 articles
    end

    xit 'saves last feed update time' do
	    feed = FeedFactory.build
	    FeedFetcher.stub(:fetch).and_return([feed])
      FeedsUpdater.update_all

      expect(Channel.first.last_updated).to eq Time.now
    end

    context 'nothing downloaded' do

    end
  end

end