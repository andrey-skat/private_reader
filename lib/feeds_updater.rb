require_relative '../app/models/feed'
require_relative '../app/models/article'

class FeedsUpdater

  #TODO: make fetching in threads
  def self.update_all
    Feed.all.each do |feed|
      rss = Feedzirra::Feed.fetch_and_parse(feed.url)
      feed.add_new_articles(rss.entries)
    end
  end

end