class RemoveFieldsFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :old_balance, :integer
    remove_column :transactions, :new_balance, :integer
  end
end
