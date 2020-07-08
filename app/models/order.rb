class Order < ApplicationRecord
  belongs_to :spot
  belongs_to :client
  belongs_to :order_status
  has_many :order_items

  after_initialize :default_values

  class << self
    def first_step_status
      ret_order_status = nil
      OrderStatus.all.each do |order_status|
        if order_status.order_flow.flow_step == 1
          ret_order_status = order_status
          break
        end
      end
      ret_order_status
    end
  end

  private
  def default_values
    self.ordered ||= DateTime.now.to_date
    self.placed ||= DateTime.now.to_date
  end
end
