class Recipient < ActiveRecord::Base
  attr_accessible :notification_id, :person_id, :uuid

  belongs_to :notification
  belongs_to :person

  has_many :messages
  has_many :responses

  def name
    self.person.name
  end

  def last_intention
    if !(responses.blank?)
      responses.last.intention
    else
      "No response yet"
    end
  end
end
