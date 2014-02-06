# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :complaint do
    association :problem
    association :complaint_status
    complainer_email "MyString"
    notes "MyString"
    targeted_question 1
    targeted_user 1
    targeted_image 1
  end
end
