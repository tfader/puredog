class ExamGroupExam < ApplicationRecord
  belongs_to :exam_group
  belongs_to :exam
end
