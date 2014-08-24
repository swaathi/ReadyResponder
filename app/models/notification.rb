class Notification < ActiveRecord::Base
  attr_accessible :author_id, :body, :channels, :send_trigger, :comments, :event, :event_id, :sent_at, :status, :subject, :recipient_ids, :person_ids

  CHANNELS= ['email']
  STATUSES= ['New', 'Not Sent', 'Scheduled', 'Sending', 'Complete']
  SEND_TRIGGERS= [ 'Manual-Now' , 'Manual-Later']
  # Could use a schedule to send a notification, in a later revision
  # Could also use a code block as a trigger, in a later revision
  # Code block would be useful for certification expiration

  validates_presence_of :channels, :send_trigger
  belongs_to :event
  # The data model will need to change to accomadate receipients
  # separate from the message.
  has_many :recipients
  has_many :messages, :through => :recipients
  has_many :people, :through => :recipients
  has_many :responses, :through => :recipients

  def initialize(attributes = {})
    super
    channels = ['email']
    status = 'New'
    send_trigger = 'Manual-Now'
  end

  def author_name
    author = Person.find(self.author_id) unless author_id.blank?
    return author.name if author
  end

  def expiration_date
  # Pending on this feature. This will tell the notifiation when to quit trying
  #  date = DateTime.parse("2001-08-01 08:00:00")
  #  Time.now
  end

  def set_status

  end

  def notify
    self.update_attribute(:status, 'Working')
    event = self.event
    recipients.each do |recipient|
      person = recipient.person
      if self.channels.include? "email"
        person.email_channels.first.each do |email_address|
          MessageMailer.callout(self, recipient, email_address.content).deliver
          # Need to create a message now to capture what we just sent
          Message.create(:recipient => recipient,
                          :status => 'Sent',
                          :channel => 'EMail',
                          :processed_at => Time.now)
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
