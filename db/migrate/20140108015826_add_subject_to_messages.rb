class AddSubjectToMessages < ActiveRecord::Migration
  def up
    add_column :messages, :body, :text
    add_column :messages, :subject, :string
    remove_column :messages, :content
  end

  def down
    remove_column :messages, :body
    remove_column :messages, :subject
    add_column :messages, :content, :string
  end

end
