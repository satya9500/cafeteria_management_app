class AddTotalPriceToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :total_price, :bigint
  end
end
