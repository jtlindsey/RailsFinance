class AddAccountSubtypeColumns < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.integer :credit_limit
      t.decimal :interest_rate
    end
  end
end
