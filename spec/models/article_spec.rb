require 'spec_helper'

require_relative '../../app/models/article'

describe Article do

  describe '.add' do
    let(:feed) { FactoryGirl.create(:feed) }
    let(:rss) { FeedzirraFeedFactory.build }

    it 'adds new articles by Feedzirra Entry data' do
      expect(Article.count).to eq 0
      feed.articles.add(rss.entries[0])
      expect(Article.count).to eq 1
    end
  end
end