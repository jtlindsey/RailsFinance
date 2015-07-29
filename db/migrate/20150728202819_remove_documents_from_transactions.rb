class RemoveDocumentsFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :documents, :json
  end
end
