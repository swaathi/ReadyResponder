class Notification < ActiveRecord::Base
  attr_accessible :author_id, :body, :channels, :send_trigger, :comments, :event, :event_id, :sent_at, :status, :subject

  CHANNELS= ['email']
  STATUSES= ['New', 'Not Sent', 'Scheduled', 'Sending', 'Complete']
  SEND_TRIGGERS= [ 'Manual-Now' , 'Manual-Later']
  # Could use a schedule to send a notification, in a later revision
  # Could also use a code block as a trigger, in a later revision

  validates_presence_of :channels, :send_trigger
  belongs_to :event
  has_many :messages
  has_many :people, :through => :messages

  def initialize(attributes = {})
    super
    self.channels = ['email']
    self.status = 'New'
    self.send_trigger = 'Manual-Now'
  end

  def set_status

  end

  def notify
    self.update_attributes(status: 'Working')
    event = self.event
    self.recipient_groups.each do |group|
      event.roster(group).each do |recipient|

        if self.channels.include? "email"
          recipient.email.each do |email_address|
            MessageMailer.callout(self, recipient, email_address.content).deliver
          end
        end
      end
    end
  end

  def event_title
    event.title unless event.blank?
  end
  def recipient_groups
    ['Available','Unknown']
  end
end
