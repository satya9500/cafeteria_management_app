class Order < ApplicationRecord
  validates :user_id, presence: true
  has_many :order_items
  belongs_to :user
end
