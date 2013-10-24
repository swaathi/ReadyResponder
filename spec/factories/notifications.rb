# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    event_id 1
    author_id 1
    status "MyString"
    channels "MyString"
    subject "MyString"
    body "MyString"
    sent_at "2013-10-24 07:44:14"
    comments "MyText"
  end
end
