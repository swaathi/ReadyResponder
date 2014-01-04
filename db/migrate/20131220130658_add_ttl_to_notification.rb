class AddTtlToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :ttl, :integer
  end
end
