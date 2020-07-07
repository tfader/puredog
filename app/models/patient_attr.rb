class PatientAttr < ApplicationRecord
  validates :attr, presence: true, uniqueness: true
  validates :mandatory, presence: true

  belongs_to :attr

  def mandatory_desc
    if mandatory == 1
      'Tak'
    else
      'Nie'
    end
  end
end
