class OrderFlow < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :flow_step, presence: true, uniqueness: true


  def name_with_step
    [name, flow_step].compact.join(' / ')
  end

end
