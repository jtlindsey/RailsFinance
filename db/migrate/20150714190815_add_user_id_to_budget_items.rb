class AddUserIdToBudgetItems < ActiveRecord::Migration
  def change
    add_column :budget_items, :user_id, :integer
  end
end
