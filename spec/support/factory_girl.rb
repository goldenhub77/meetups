require 'factory_girl'

FactoryGirl.define do
  factory :user do
    provider "github"
    sequence(:uid) { |n| n }
    sequence(:username) { |n| "jarlax#{n}" }
    name "Sean"
    sequence(:email) { |n| "jarlax#{n}@launchacademy.com" }
    avatar_url "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
  end

  factory :meetup do
    sequence(:name) { |n| "helicopter ride#{n}" }
    location "NYC"
    creator "john_smith88"
    description "take a ride above the city"
    start_date "02-02-02 12:00"
    end_date "02-02-02 13:00"
  end
end
