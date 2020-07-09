class Unit < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  has_many :rates_from, class_name: 'UnitRate', foreign_key: :from_unit_id
  has_many :rates_to, class_name: 'UnitRate', foreign_key: :to_unit_id

  class << self
    def search_by_code_or_name(p_search)
      p_el = p_search.split
      unit = nil
      if p_el.count > 0
        v_i = 0
        v_i.upto(p_el.count) do |i|
          unit = find_by(code: p_el[i])
          if unit.present?
            break
          else
            unit = find_by(name: p_el[i])
            if unit.present?
              break
            end
          end
        end
      end
      unit
    end
  end

  def name_with_code
    [code, name].compact.join(' / ')
  end

end
