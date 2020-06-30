class CreateUserGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :user_groups, :id => false do |t|
      t.belongs_to :user
      t.belongs_to :group
    end
  end
end
