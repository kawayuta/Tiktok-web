class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_unique_id, :text, unique:true
    add_column :users, :user_sec_id, :text, unique:true
  end
end
