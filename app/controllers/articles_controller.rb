require_relative '../models/article'

class PrivateReader < Sinatra::Base

  get '/articles' do
    Rabl.render Article.all, 'articles/list'
  end

  get '/articles/:id' do
    article = Article.find(params[:id])
    Rabl.render article, 'articles/show'
  end

  get '/feeds/:feed_id/articles' do
    articles = Article.where(feed_id: params[:feed_id])
    Rabl.render articles, 'articles/list'
  end

end