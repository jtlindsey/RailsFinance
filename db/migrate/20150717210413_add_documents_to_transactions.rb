class AddDocumentsToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :documents, :json
  end
end
