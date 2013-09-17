require 'ostruct'

class FeedzirraFactory
  class << self
    def build_list(count)
      result = []
      count.times do
        result << build
      end
      result
    end

    def sequence_number
      @sequence_number ||= 0
      @sequence_number += 1
    end

    def build
      sequence_number
      create_fake
    end
  end
end

class FeedzirraFeedFactory < FeedzirraFactory
  private
  def self.create_fake
    OpenStruct.new(
        title: "title_#{sequence_number}",
        feed_url: "http://example#{sequence_number}.com/",
        etag: "etag_#{sequence_number}",
        last_modified: Time.new.getutc - (sequence_number-1).day,
        entries: FeedzirraArticleFactory.build_list(3)
    )
  end
end

class FeedzirraArticleFactory < FeedzirraFactory
  private
  def self.create_fake
    OpenStruct.new(
        title: "title_#{sequence_number}",
        url: "http://example#{sequence_number}.com",
        author: '',
        summary: "summary_#{sequence_number}",
        content: '',
        published: Time.new.getutc - (sequence_number-1).day,
        categories: []
    )
  end
end