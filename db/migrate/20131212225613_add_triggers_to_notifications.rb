class AddTriggersToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :send_trigger, :string
  end
end
