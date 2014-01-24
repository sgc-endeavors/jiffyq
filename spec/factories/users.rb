# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	sequence(:email) { |i| "sethgeyer#{i}@ggmail.com" }
  	password "iluvunicorns"
  end
end
