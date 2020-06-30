class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.belongs_to :user
      t.belongs_to :group
      t.datetime :transaction_date
      t.timestamps
    end
  end
end
