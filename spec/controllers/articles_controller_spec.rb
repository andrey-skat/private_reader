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

  describe 'GET /articles/:id' do
    it 'shows article data' do
      FactoryGirl.create(:article)

      get '/articles/1'

      expect(JSON.parse(last_response.body)['title']).to eq 'title_1'
    end
  end

end