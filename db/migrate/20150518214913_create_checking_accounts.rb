class CreateCheckingAccounts < ActiveRecord::Migration
  def change
    create_table :checking_accounts do |t|
      t.string :name, limit: 45
      t.string :last4
      t.string :status, limit: 45
      t.integer :balance

      t.timestamps null: false
    end
  end
end
