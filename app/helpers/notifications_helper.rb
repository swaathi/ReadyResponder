module NotificationsHelper
  def event_name
    if @event.blank?
      "No event associated"
    else
      @event.title
    end
  end
end
