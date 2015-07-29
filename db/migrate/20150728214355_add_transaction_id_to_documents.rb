class AddTransactionIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :transaction_id, :integer
  end
end
