class ChangeAmountOnTransactions < ActiveRecord::Migration
  def change
    rename_column :transactions, :amount, :amount_cents
    change_column :transactions, :amount_cents, :integer, :limit => 8
  end
end
