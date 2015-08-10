class AddInterestPaymentToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :interest_payment_cents, :integer
  end
end
