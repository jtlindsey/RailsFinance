class AddDetailsToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :old_balance, :integer
    add_column :transactions, :new_balance, :integer
  end
end
