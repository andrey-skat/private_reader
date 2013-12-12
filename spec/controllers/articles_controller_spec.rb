require 'spec_helper'

describe 'ArticlesController' do

  describe 'GET /articles' do
    it 'shows all articles' do
      FactoryGirl.create_list(:article, 3)

      get '/articles'

      articles = JSON.parse(last_response.body)
      expect(articles.count).to eq 3
      expect(articles[0]['title']).to eq 'title_1'
    end
  end

  describe 'GET /channels/:channel_id/articles' do
    it 'shows all articles for feed' do
      FactoryGirl.create(:article, id: 1)
      FactoryGirl.create(:article, id: 2)

      get '/channels/2/articles'

      articles = JSON.parse(last_response.body)
      expect(articles.count).to eq 1
      expect(articles[0]['channel_id']).to eq 2
    end
  end

  describe 'GET /articles/:id' do
    it 'shows article data' do
      FactoryGirl.create(:article)

      get '/articles/1'

      expect(JSON.parse(last_response.body)['title']).to eq 'title_1'
    end
  end

end