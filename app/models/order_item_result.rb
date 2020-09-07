class OrderItemResult < ApplicationRecord

  belongs_to :order_item
  belongs_to :unit
  belongs_to :exam

  after_initialize :default_values

  def result_norm
    ret = 0
    default_norm = exam.default_norm
    if default_norm.present? and result.present?
      if result < default_norm.norm_min
        ret = -1
      else
        if result > default_norm.norm_max
          ret = 1
        end
      end
    end
    ret
  end

  private
  def default_values
    self.result_time ||= DateTime.now
  end
end
