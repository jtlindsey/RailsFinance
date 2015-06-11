class ChangeColumnNameAgainInTransactionsTable < ActiveRecord::Migration
  def change
    rename_column :transactions, :from_to_name, :payee
  end
end
