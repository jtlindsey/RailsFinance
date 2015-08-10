class AddLoanAmountToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :loan_amount_cents, :integer
  end
end
