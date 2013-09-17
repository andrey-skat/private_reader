require_relative '../app/models/channel'
require_relative '../app/models/article'

class FeedsUpdater

  #TODO: make fetching in threads
  def self.update_all
    Channel.all.each do |feed|
      rss = Feedzirra::Feed.fetch_and_parse(feed.url)
      feed.add_new_articles(rss.entries)
      #feed.last_updated = rss.last_modified
      feed.save
    end
  end

end