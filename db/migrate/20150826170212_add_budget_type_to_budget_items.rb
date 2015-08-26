class AddBudgetTypeToBudgetItems < ActiveRecord::Migration
  def change
    add_column :budget_items, :budget_type, :string
  end
end
