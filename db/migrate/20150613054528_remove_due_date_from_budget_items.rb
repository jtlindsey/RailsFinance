class RemoveDueDateFromBudgetItems < ActiveRecord::Migration
  def change
    remove_column :budget_items, :due_date, :datetime
  end
end
