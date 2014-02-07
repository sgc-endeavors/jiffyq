# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :poll do
    association :image
    association :user
    #sequence(:question) { |i| "Am I Cooler Than Gerard?-#{i}" }
    question "Am I Cooler Than Gerard?"
    button1 "Yes I am!"
    button2 "No I'm Not"
    origin_poll 1
    page_views 0
    response1 "You are wrong."
    response2 "You are correct."
    sequence(:identifier) { |i| "abc1234567-#{i}" }
  end
end
