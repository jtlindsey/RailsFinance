class RemoveAssetLiabilityFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :asset_liability
  end
end
