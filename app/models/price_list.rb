class PriceList < ApplicationRecord
  belongs_to :client
  has_many :price_list_items

  before_save :default_values

  private
  def default_values
    if self.name.blank?
      self.name = self.client.name
    end
  end
end
