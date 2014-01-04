# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipient do
    person_id 1
    notification_id 1
    uuid "MyString"
  end
end
