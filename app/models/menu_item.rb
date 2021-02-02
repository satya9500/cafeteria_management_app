class MenuItem < ApplicationRecord
  validates :menu_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  belongs_to :menu
end
