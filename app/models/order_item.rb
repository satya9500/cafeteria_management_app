class OrderItem < ApplicationRecord
  validates :order_id, presence: true
  validates :menu_item_id, presence: true
  validates :menu_item_name, presence: true
  validates :menu_item_price, presence: true
  belongs_to :order
  belongs_to :menu_item
end
