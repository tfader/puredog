class PriceListItem < ApplicationRecord
  validates :price, presence: true
  validates :is_cito, presence: true
  validate :check_unique

  belongs_to :price_list
  belongs_to :exam, optional: true
  belongs_to :exam_group, optional: true

  private
  def check_unique
    if Parameter.get_value('price_by_group') == 0
      if price_list.price_list_items.where('exam_id = ? and is_cito = ?', self.exam_id, self.is_cito).count > 0
        errors.add(:price_list_item, 'price_list_item.exam_not_unique')
      end
    else
      if price_list.price_list_items.where('exam_group_id = ? and is_cito = ?', self.exam_group_id, self.is_cito).count > 0
        errors.add(:price_list_item, 'price_list_item.exam_group_not_unique')
      end
    end
  end
end
