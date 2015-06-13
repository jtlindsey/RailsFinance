class ChangeCategoryAmountType < ActiveRecord::Migration
  def up
    rename_column :budget_items, :amount, :amount_cents
  end
end
