require 'spec_helper'

require_relative '../../lib/feeds_updater'

describe FeedsUpdater do

  before do
    FactoryGirl.create_list(:channel, 3)

    #builds 3 feeds with 3 articles each
    feedzirra_feeds = FeedzirraFeedFactory.build_list(3)
    Feedzirra::Feed.stub(:fetch_and_parse).and_return(feedzirra_feeds)
  end

  describe '.update_all' do

    it 'downloads new articles for channels' do
      expect(Feedzirra::Feed).to receive(:fetch_and_parse).exactly(3).times

      FeedsUpdater.update_all
    end

    it 'saves downloaded articles' do
      expect(Article.count).to eq 0
      FeedsUpdater.update_all
      expect(Article.count).to eq 9 # 3 feeds with 3 articles each
    end

    xit 'saves last feed update time' do
      feedzirra_feed = FeedzirraFeedFactory.build
      Feedzirra::Feed.stub(:fetch_and_parse).and_return([feedzirra_feed])
      FeedsUpdater.update_all

      expect(Channel.first.last_updated).to eq Time.new.getutc
    end

    context 'nothing downloaded' do

    end
  end

end