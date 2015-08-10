class AddMinimumEscrowPaymentToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :minimum_escrow_payment_cents, :integer
  end
end
