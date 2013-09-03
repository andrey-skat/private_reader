class Feed < ActiveRecord::Base
  has_many :articles, dependent: :delete_all
  validates :url, presence: true, uniqueness: true
end