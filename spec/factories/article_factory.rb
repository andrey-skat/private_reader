FactoryGirl.define do
  factory :article do
    feed

    sequence(:title) { |n| "title_#{n}" }
    sequence(:published) { |n| Date.today + (n-1).day }
    sequence(:body) { |n| "body_#{n}" }
    sequence(:url) { |n| n = '' if n == 1; "http://example#{n}.com/" }
  end
end