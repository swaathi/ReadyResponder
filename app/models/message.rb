class Message < ActiveRecord::Base
  attr_accessible :channel, :content, :notification_id, :person_id, :processed_at, :processed_by, :slug, :status

  belongs_to :notifications
  belongs_to :person

  def recipient_email
    person.email
  end
end
