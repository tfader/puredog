class Exam < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :exam_group
  belongs_to :material
  has_many :exam_varieties
  has_many :exam_units

  class << self
    def search_by_name(p_search)
      p_el = p_search.split
      exam = nil
      if p_el.count > 0
        v_i = 0
        v_i.upto(p_el.count) do |i|
          exam = find_by(name: p_el[i])
          if exam.present?
            break
          end
        end
      end
      exam
    end
  end

  def variety_names
    variety_names = nil
    exam_varieties.each do |exam_variety|
      if variety_names.blank?
        variety_names = exam_variety.variety.name
      else
        variety_names = [variety_names, exam_variety.variety.name].compact.join(', ')
      end
    end
    variety_names
  end

  def unit_names
    units_names = nil
    exam_units.each do |exam_unit|
      if units_names.blank?
        units_names = exam_unit.unit.name
      else
        units_names = [unit_names, exam_unit.unit.name].compact.join(', ')
      end
    end
    units_names
  end

  def unit_codes
    units_codes = nil
    exam_units.each do |exam_unit|
      if units_codes.blank?
        units_codes = exam_unit.unit.code
      else
        units_codes = [units_codes, exam_unit.unit.code].compact.join(', ')
      end
    end
    units_codes
  end

  def name_with_group_name
    [exam_group.name, name].compact.join(' / ')
  end

  def default_unit
    exam_unit = exam_units.where('is_default = 1').first
    if exam_unit.blank?
      exam_unit = exam_units.first
    end
    exam_unit.unit
  end


end
