class PatientAttrValue < ApplicationRecord
  belongs_to :attr
  belongs_to :patient
end
