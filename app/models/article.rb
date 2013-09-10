#TODO: add entry_id

class Article < ActiveRecord::Base
  belongs_to :feed
  validates :feed_id, presence: true

  def self.add(data)
    create!(
        title: data.title,
        url: data.url,
        body: data.summary,
        published: Date.today
    )
  end
end