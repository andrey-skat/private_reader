require_relative '../app/models/channel'
require_relative '../app/models/article'

class FeedsUpdater

  #TODO: make fetching in threads
  def self.update_all
    Channel.all.each do |channel|
      feed = FeedFetcher.fetch(channel.url)
      channel.add_new_articles(feed[:entries])
      #channel.last_updated = feed[:last_modified]
      channel.save
    end
  end

end