class DropTableMessagesPeople < ActiveRecord::Migration
  def up
    drop_table :messages_people
  end

  def down
    add_table :messages_people
  end
end
