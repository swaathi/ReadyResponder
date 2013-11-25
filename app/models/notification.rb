class Notification < ActiveRecord::Base
  attr_accessible :author_id, :body, :channels, :comments, :event, :event_id, :sent_at, :status, :subject

  CHANNELS= ['email']
  validates_presence_of :channels
  belongs_to :event
  has_many :messages
  has_many :people, :through => :messages

  def notify
    event = self.event
    recipient = event.scheduled_people.first
    self.event_groups.each { |event_group| recipients << event.send(event_group) }

    if self.channels.include? "email"
      recipient.email.each do |email_address|
        MessageMailer.callout(self, recipient, email_address.content).deliver
      end
    end
  end

  def event_title
    event.title unless event.blank?
  end
  def event_groups
    ['Available','Unknown']
  end
end
