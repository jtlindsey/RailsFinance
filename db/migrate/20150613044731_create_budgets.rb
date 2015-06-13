class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :category
      t.integer :amount
      t.string :period
      t.datetime :due_date

      t.timestamps null: false
    end
  end
end
