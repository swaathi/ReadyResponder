class AddEventGroupsToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :event_group, :string
  end
end
