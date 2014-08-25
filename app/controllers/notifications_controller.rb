class NotificationsController < ApplicationController
  # POST notification/:id/notify
  def notify
    @notification = Notification.find(params[:id])
    @event = @notification.event

    @notification.notify
    redirect_to notification_url(@notification)
  end

  def index
    if params[:event_id]
      @event = Event.find(params[:event_id])
      @notifications = @event.notifications
    else
      @notifications = Notification.all(:include => :event)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notifications }
    end
  end

  def show
    @notification = Notification.find(params[:id])
    @event = @notification.event

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification }
    end
  end

  def new
    @notification = Notification.new
    @event = Event.find(params[:event_id]) if params[:event_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification }
    end
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def create
    @notification = Notification.new(params[:notification])
    # This explicit call to notification.event will be a problem
    # once notifications are poly-morphic
    @event = @notification.event
    respond_to do |format|
      if @notification.save
        format.html { redirect_to @event, notice: 'Notification was successfully created.' }
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.html { render action: "new" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end
end
