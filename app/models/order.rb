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

  def check_status
    if order_status.name.include?('new')
      if order_items.count > 0
        'ready_to_do'
      else
        'new'
      end
    end
  end

  def check_all_results
    if order_items.present?
      order_items.each do |order_item|
        if order_item.order_item_results.blank?
          false
        end
      end
      true
    else
      false
    end
  end

  def total_value
    v_total_value = 0
    order_items.each do |order_item|
      v_total_value += order_item.item_price
    end
    v_total_value
  end

  private
  def default_values
    self.ordered ||= DateTime.now.to_date
    self.placed ||= DateTime.now.to_date
  end
end
