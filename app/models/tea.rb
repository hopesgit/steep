class Tea < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :brew_time, presence: true
  validates :api_id, presence: true, uniqueness: true

  has_many :subscriptions
  has_many :customers, through: :subscriptions
end
