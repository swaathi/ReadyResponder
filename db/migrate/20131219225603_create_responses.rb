class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :recipient_id
      t.string :intention
      t.datetime :eta
      t.datetime :etd
      t.decimal :duration, precision: 5, scale: 2
      t.string :channel

      t.timestamps
    end
  end
end
