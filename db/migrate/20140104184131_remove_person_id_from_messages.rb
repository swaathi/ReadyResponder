class RemovePersonIdFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :person_id
  end
end
