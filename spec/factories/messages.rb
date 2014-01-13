# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    title "Cool"
    image_id 1
    question "Am I Cooler Than Gerard"
    button1 "Yes I am!"
    button2 "No I'm Not"
    origin_message 1
    address "seth.geyer@gmail.com"
    response1 "You are wrong."
    response2 "You are correct."
  end
end
