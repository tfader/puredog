class Patient < ApplicationRecord
  validates :name, presence: true

  has_many :patient_attr_values
  belongs_to :variety

  def attr_value(p_attr_id)
    attr_value = patient_attr_values.find_by(:attr_id => p_attr_id)
    if attr_value.present?
      attr_value.attr_value
    else
      'N/A'
    end
  end

  def attr_present(p_attr_id)
    if patient_attr_values.find_by(:attr_id => p_attr_id).present?
      patient_attr_values.find_by(:attr_id => p_attr_id)
    else
      false
    end
  end

end
