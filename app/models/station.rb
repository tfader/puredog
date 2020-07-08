class Station < ApplicationRecord
  belongs_to :spot
  has_many :station_exams
end
