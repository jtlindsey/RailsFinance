class AddPrincipalPaymentToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :principal_payment_cents, :integer
  end
end
