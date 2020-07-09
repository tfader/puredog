class OrderItemResult < ApplicationRecord
  validates :result, presence: true

  belongs_to :order_item
  belongs_to :unit

  after_initialize :default_values

  private
  def default_values
    self.result_time ||= DateTime.now
  end
end
