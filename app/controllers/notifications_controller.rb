class NotificationsController < ApplicationController
  # POST notification/:id/notify
  def notify
    @notification = Notification.find(params[:id])
    @recipient = Person.first
    MessageMailer.callout(@notification, @recipient).deliver
  end

  def index
    @notifications = Notification.all

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
    @notification.status = 'New'
    @notification.event_id = params[:event_id]
    @event = @notification.event

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

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
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
