FactoryGirl.define do
  factory :article do
    feed

    sequence(:title) { |n| "title_#{n}" }
    sequence(:datetime) { |n| Date.today + (n-1).day }
    sequence(:body) { |n| "body_#{n}" }
    sequence(:url) { |n| n == 1 ? "http://example.com/" : "http://example#{n}.com/" }
  end
end