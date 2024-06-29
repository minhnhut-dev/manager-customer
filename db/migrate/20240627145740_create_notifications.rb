class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.text :content
      t.integer :status
      t.integer :customer_id

      t.timestamps
    end
  end
end
