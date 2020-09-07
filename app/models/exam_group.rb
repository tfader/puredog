class ExamGroup < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :exam_group_exams

  class << self
    def search_by_name(p_search)
      p_el = [p_search]
      exam_group = nil
      if p_el.count > 0
        v_i = 0
        v_i.upto(p_el.count) do |i|
          exam_group = find_by(name: p_el[i])
          if exam_group.present?
            break
          end
        end
      end
      exam_group
    end
  end
end
