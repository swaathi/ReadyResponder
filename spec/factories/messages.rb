# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    notification_id 1
    person_id 1
    status "MyString"
    channel "MyString"
    content "MyString"
    processed_at "2013-10-24 07:55:04"
    processed_by "MyString"
    slug "MyString"
  end
end
