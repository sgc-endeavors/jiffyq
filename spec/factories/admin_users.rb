# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do
  	email "sethgeyer@gmail.com"
  	password 'hotchix5'
  end
end
