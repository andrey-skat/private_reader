require 'spec_helper'

require_relative '../../lib/feeds_updater'

describe FeedsUpdater do

  before do
    FactoryGirl.create_list(:feed, 3)

    #builds 3 feeds with 3 articles each
    feedzirra_feeds = FeedzirraFeedFactory.build_list(3)
    Feedzirra::Feed.stub(:fetch_and_parse).and_return(feedzirra_feeds)
  end

  describe '.update_all' do

    it 'downloads new articles for feeds' do
      expect(Feedzirra::Feed).to receive(:fetch_and_parse).exactly(3).times

      FeedsUpdater.update_all
    end

    it 'saves downloaded articles' do
      expect(Article.count).to eq 0
      FeedsUpdater.update_all
      expect(Article.count).to eq 9 # 3 feeds with 3 articles each
    end

    context 'nothing donwloaded' do
      it 'doesnt crash'
    end
  end

end