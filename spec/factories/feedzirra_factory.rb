require 'ostruct'
require_relative 'factory'

class FeedzirraFeedFactory < Factory
  private
  def self.create_fake
    OpenStruct.new(
        title: "title_#{sequence_number}",
        feed_url: "http://example#{sequence_number}.com/",
        etag: "etag_#{sequence_number}",
        last_modified: Time.now.utc - (sequence_number-1).day,
        entries: FeedzirraEntryFactory.build_list(3)
    )
  end
end

class FeedzirraEntryFactory < Factory
  private
  def self.create_fake
    OpenStruct.new(
        title: "title_#{sequence_number}",
        url: "http://example#{sequence_number}.com",
        author: '',
        summary: "summary_#{sequence_number}",
        content: '',
        published: Time.now.utc - (sequence_number-1).day,
        categories: []
    )
  end
end