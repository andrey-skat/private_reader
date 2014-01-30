FactoryGirl.define do
  factory :article do
    channel

    sequence(:title) { |n| "title_#{n}" }
    sequence(:published) { |n| Time.now.utc + (n-1).day }
    sequence(:body) { |n| "body_#{n}" }
    sequence(:url) { |n| n = '' if n == 1; "http://example#{n}.com/" }
  end
end