class ChangeColumnNameInTransactionsTable < ActiveRecord::Migration
  def change
    rename_column :transactions, :for, :from_to_name
  end
end
