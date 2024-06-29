class AddReferenceToNotification < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :notifications, :customers, column: :customer_id
  end
end
