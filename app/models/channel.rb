class Channel < ActiveRecord::Base
  has_many :articles, dependent: :delete_all
  validates :url, presence: true, uniqueness: true

  def self.subscribe(url)
	  feed_data = FeedFetcher.discover url
	  feed_data.delete(:entries)
	  create!(feed_data)
  end

  def add_new_articles(items)
    items.each do |article|
      articles.add(article) if !self.last_updated || article[:published] > self.last_updated # rely on last updated date for now
    end
  end
end