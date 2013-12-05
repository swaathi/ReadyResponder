class Notification < ActiveRecord::Base
  attr_accessible :author_id, :body, :channels, :comments, :event, :event_id, :sent_at, :status, :subject

  CHANNELS= ['email']
  STATUSES= ['new', 'scheduled', 'Sending', 'Complete']

  validates_presence_of :channels
  belongs_to :event
  has_many :messages
  has_many :people, :through => :messages

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
