class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :type
      t.string :name, limit: 45
      t.string :last4, limit: 4
      t.string :status, :default => 'Open'
      t.integer :balance_cents, :limit => 8
    end
  end
end
