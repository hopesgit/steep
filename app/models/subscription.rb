class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :tea_id, presence: true
  validates :customer_id, presence: true
  validates :status, presence: true

  enum status: [:active, :inactive]
end
