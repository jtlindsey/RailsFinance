class AddWatchColumnToBudget < ActiveRecord::Migration
  def change
    add_column :budget_items, :watch, :boolean, :default => false
  end
end
