class ChangeTimestampsInAccounts < ActiveRecord::Migration
  def change
    remove_timestamps :accounts
    add_timestamps :accounts#, null: false
  end
end
