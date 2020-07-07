class Unit < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  has_many :rates_from, class_name: 'UnitRate', foreign_key: :from_unit_id
  has_many :rates_to, class_name: 'UnitRate', foreign_key: :to_unit_id

  def name_with_code
    [code, name].compact.join(': ')
  end

end
