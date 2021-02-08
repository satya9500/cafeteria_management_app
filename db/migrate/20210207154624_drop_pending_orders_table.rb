class DropPendingOrdersTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :pending_orders
  end
end
