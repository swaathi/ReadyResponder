class Notification < ActiveRecord::Base
  # Notifications needs to decide who to contact and how. 
  # I think a message will be an single message to a single person
  # The message will be expected to find the address to send to
  #
  attr_accessible :author_id, :body, :channels, :comments, :event_id, :sent_at, :status, :subject

  CHANNELS= ['email']
  validates_presence_of :channels
  belongs_to :event
  has_many :messages
  has_many :people, :through => :messages

  def notify(notification)
    event = notification.event
    recipient = event.scheduled_people.first

    if notification.channels.include? "SMS" then
      delivery_addresses = recipient.sms_address(notification.priority)
      delivery_addresses.each do |delivery_address|
        notify_via_sms(notification, delivery_address)
      end
    end
  end

  def notify_via_sms(notification, recipients)
    MessageMailer.callout(notification, recipient_address).deliver

  end

  def event
    return Event.new if event_id.blank?
    super
  end

  def event_title
    return "No Event" if event.blank?
    return "Unknown" if event.title.blank?
    event.title
  end

end
