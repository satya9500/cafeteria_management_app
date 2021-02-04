class AddOrderTypeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_type, :string
    add_column :orders, :status, :string
    add_column :orders, :date, :datetime
    add_column :orders, :delivered_at, :datetime
  end
end
