class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :date
      t.string :for
      t.text :comment
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
