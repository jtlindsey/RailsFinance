class AddPaymentAmountToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :payment_amount_cents, :integer
  end
end
