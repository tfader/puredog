class EmployeeSpot < ApplicationRecord
  validates :date_from, presence: true
  validates :spot, presence: true
  validates :employee, presence: true

  belongs_to :spot
  belongs_to :employee
end
