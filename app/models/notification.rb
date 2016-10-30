class Notification < ActiveRecord::Base
  belongs_to :event
  # has_many :recipients

  enum status: [ :pending, :active, :canceled, :complete, :expired ]

  before_create :validate_status
  before_update :validate_status_change, if: :status_changed?

  def title
    event.try(:title).presence || 'None'
  end

  private
  # Prevents notification from being set to complete or expired during creation
  def validate_status
    if complete? || expired?
      errors.add(:unpermitted, "can only be Pending, Active or Canceled")
    end
  end

  def was_pending?
    status_was == Notification.statuses.keys[0]
  end

  # Allows pending notification to only be moved to active or canceled
  def validate_status_change
    if was_pending? && (complete? || expired?)
      errors.add(:unpermitted, "can only be Active or Canceled")
    end
  end
end
