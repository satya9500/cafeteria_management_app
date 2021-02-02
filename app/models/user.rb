class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :email, presence: true
  validates_uniqueness_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: %w(owner clerk customer) }
  validates :role, presence: true
  has_many :orders
end