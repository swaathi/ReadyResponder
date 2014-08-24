class Message < ActiveRecord::Base
  attr_accessible :channel, :content, :recipient, :processed_at, :processed_by, :slug, :status

  belongs_to :recipient
  has_one :person, :through => :recipient
  has_one :notification, :through => :recipient

  def recipient_email
    person.email
  end
end
