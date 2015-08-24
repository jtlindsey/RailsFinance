class AddCheckNumberToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :check_number, :integer
  end
end
