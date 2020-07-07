class ModifyUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :email
    add_index :users, :phone, unique: true
    change_column_null :users, :email, true
    change_column :users, :phone, :string, unique: true, null: false
  end
end
