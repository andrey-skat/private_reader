require_relative '../models/article'

class PrivateReader < Sinatra::Base

  get '/articles' do
    Rabl.render Article.all, 'articles/list'
  end

  get '/articles/:id' do
    article = Article.find(params[:id])
    Rabl.render article, 'articles/show'
  end

  get '/channels/:channel_id/articles' do
    articles = Article.where(channel_id: params[:channel_id]).order(published: :desc)
    Rabl.render articles, 'articles/list'
  end

end