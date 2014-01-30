require 'thread'

require_relative '../app/models/channel'
require_relative '../app/models/article'

class FeedsUpdater

  def self.update_all
		queue = Queue.new
		threads = []

    Channel.all.each do |channel|
      threads << Thread.new do
	      queue << [channel, FeedFetcher.fetch(channel.url)]
      end
    end

		threads.each(&:join)
		until queue.empty?
			channel, feed = queue.pop
			channel.add_new_articles(feed[:entries])
			#channel.last_updated = feed[:last_modified]
			#channel.save
		end
  end

end