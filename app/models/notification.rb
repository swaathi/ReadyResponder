class Notification < ActiveRecord::Base
  attr_accessible :author_id, :body, :channels, :comments, :event_id, :sent_at, :status, :subject
end
