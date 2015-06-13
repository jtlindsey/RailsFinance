class CreateBudgetItems < ActiveRecord::Migration
  def change
    create_table :budget_items do |t|
      t.string :category
      t.integer :amount
      t.string :period
      t.datetime :due_date

      t.timestamps null: false
    end
  end
end
