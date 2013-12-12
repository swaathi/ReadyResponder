FactoryGirl.define do
  factory :notification do
    status "New"
    channels "email"
    sequence (:subject) {|n| "Notification Subject#{n}" }
    body "You should know this"
    sent_at "2013-10-24 07:44:14"
    comments "These are some comments"
  end
end
