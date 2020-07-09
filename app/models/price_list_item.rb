class PriceListItem < ApplicationRecord
  validates :price, presence: true
  validates :exam, presence: true
  validates :is_cito, presence: true
  validates :exam, uniqueness: { scope: [:price_list_id, :is_cito] }
  belongs_to :price_list
  belongs_to :exam
end
