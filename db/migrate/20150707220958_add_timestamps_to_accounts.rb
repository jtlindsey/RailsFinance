class AddTimestampsToAccounts < ActiveRecord::Migration
  def change
    add_timestamps :accounts, null: false, default: DateTime.current
  end
end
