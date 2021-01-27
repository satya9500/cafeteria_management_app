class CreatePendingOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :pending_orders do |t|
      t.bigint :order_id

      t.timestamps
    end
  end
end
