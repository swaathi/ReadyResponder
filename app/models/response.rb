class Response < ActiveRecord::Base
  attr_accessible :channel, :duration, :duration, :eta, :etd, :intention, :recipient_id

  belongs_to :recipient
  has_one :person, :through => :recipient
  has_one :notification, :through => :recipient

  def to_s
    self.person.name
  end
end
