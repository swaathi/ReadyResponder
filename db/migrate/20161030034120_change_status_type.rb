class ChangeStatusType < ActiveRecord::Migration
  def change
    change_column(:notifications, :status, :integer)
  end
end
