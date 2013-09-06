FactoryGirl.define do
  factory :feed do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:url) { |n| n == 1 ? "http://example.com/" : "http://example#{n}.com/" }
  end
end