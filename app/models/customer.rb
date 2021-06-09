class Customer < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true

  has_many :subscriptions
  has_many :teas, through: :subscriptions
end
