class AddDetailToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :asset_liability, :string
  end
end
