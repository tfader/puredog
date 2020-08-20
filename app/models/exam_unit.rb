class ExamUnit < ApplicationRecord
  belongs_to :exam
  belongs_to :unit
  belongs_to :variety, optional: true

  def is_default_text
    if is_default == 1
      'Tak'
    else
      'Nie'
    end
  end
end
