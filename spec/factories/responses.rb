# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :response do
    recipient_id 1
    intention "MyString"
    eta "2013-12-19 17:56:03"
    etd "2013-12-19 17:56:03"
    duration ""
    duration ""
    channel "MyString"
  end
end
