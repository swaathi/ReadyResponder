class ChangeMessageNotificationToRecipient < ActiveRecord::Migration
  def change
    rename_column :messages, :notification_id, :recipient_id
  end
end
