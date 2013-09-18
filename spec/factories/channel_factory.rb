FactoryGirl.define do
  factory :channel do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:url) { |n| n == 1 ? "http://example.com/" : "http://example#{n}.com/" }
    sequence(:last_updated) { |n| Time.now - n.days }
  end
end