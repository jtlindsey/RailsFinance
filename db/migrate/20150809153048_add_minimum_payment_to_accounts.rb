class AddMinimumPaymentToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :minimum_payment_cents, :integer
  end
end
