class AddTransferColumnToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :transfer_ref, :integer
  end
end
