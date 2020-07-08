class Exam < ApplicationRecord
  belongs_to :exam_group
  belongs_to :material
  has_many :exam_varieties
  has_many :exam_units

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


end
