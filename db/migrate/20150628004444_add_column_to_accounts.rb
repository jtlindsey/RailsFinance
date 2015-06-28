class AddColumnToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :favorite, :boolean, :default => false
  end
end
