class OrderStatus < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :order_flow_id, presence: true

  belongs_to :order_flow
  has_many :orders

end
