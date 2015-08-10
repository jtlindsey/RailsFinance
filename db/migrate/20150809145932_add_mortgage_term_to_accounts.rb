class AddMortgageTermToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :mortgage_term, :string
  end
end
