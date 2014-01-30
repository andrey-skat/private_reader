require_relative 'factory'

class FeedFactory < Factory
	private
	def self.create_fake
		{
				name: "name_#{sequence_number}",
				url: "http://example#{sequence_number}.com/",
				etag: "etag_#{sequence_number}",
				last_updated: Time.now.utc - (sequence_number-1).day,
				entries: FeedEntryFactory.build_list(1)
		}
	end
end

class FeedEntryFactory < Factory
	private
	def self.create_fake
		{
				title: "title_#{sequence_number}",
				url: "http://example#{sequence_number}.com",
				body: "body_#{sequence_number}",
				published: Time.now.utc - (sequence_number-1).day,
		}
	end
end