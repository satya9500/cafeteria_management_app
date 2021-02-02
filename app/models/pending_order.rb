class PendingOrder < ApplicationRecord
  validates :order_id, presence: true
end
