class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :event_id
      t.integer :author_id
      t.string :status
      t.string :channels
      t.string :subject
      t.string :body
      t.datetime :sent_at
      t.text :comments

      t.timestamps
    end
  end
end
