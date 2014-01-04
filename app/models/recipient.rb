class Recipient < ActiveRecord::Base
  attr_accessible :notification_id, :person_id, :uuid

  belongs_to :notification
  belongs_to :person

  has_many :messages
  has_many :responses

  def to_s
    self.person.name
  end
end
