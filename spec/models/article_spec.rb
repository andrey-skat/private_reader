require 'spec_helper'

require_relative '../../app/models/article'

describe Article do

  describe '.add' do
    let(:channel) { FactoryGirl.create(:channel) }
    let(:feed) { FeedzirraFeedFactory.build }

    it 'adds new articles by Feedzirra Entry data' do
      expect(Article.count).to eq 0
      channel.articles.add(feed.entries[0])
      expect(Article.count).to eq 1
    end
  end
end