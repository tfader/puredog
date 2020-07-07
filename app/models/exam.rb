class Exam < ApplicationRecord
  belongs_to :exam_group
  belongs_to :material
  has_many :exam_varieties
  has_many :exam_units

  def exam_varieties_names
    varieties_name = nil
    exam_varieties.each do |exam_variety|
      if varieties_name.blank?
        varieties_name = exam_variety.variety.name
      else
        varieties_name = [varieties_name, exam_variety.variety.name].compact.join(', ')
      end
    end
    varieties_name
  end
end
