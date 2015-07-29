class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :efile

      t.timestamps null: false
    end
  end
end
