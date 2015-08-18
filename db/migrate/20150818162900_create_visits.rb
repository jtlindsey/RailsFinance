class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :user_id
      t.inet :user_ip
      t.string :user_email

      t.timestamps null: false
    end
  end
end
