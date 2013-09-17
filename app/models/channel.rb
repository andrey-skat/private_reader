class Channel < ActiveRecord::Base
  has_many :articles, dependent: :delete_all
  validates :url, presence: true, uniqueness: true

  def add_new_articles(items)
    items.each do |article|
      articles.add(article)
    end
  end
end