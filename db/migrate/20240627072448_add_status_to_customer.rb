class AddStatusToCustomer < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :status, :integer
  end
end
