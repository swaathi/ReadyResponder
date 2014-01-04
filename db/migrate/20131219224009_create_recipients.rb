class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.integer :person_id
      t.integer :notification_id
      t.string :uuid, :status

      t.timestamps
    end
  end
end
