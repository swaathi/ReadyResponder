class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :notification_id
      t.integer :person_id
      t.string :status
      t.string :channel
      t.string :content
      t.datetime :processed_at
      t.string :processed_by
      t.string :slug

      t.timestamps
    end
  end
end
