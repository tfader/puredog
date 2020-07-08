class Patient < ApplicationRecord
  validates :name, presence: true

  has_many :patient_attr_values
  belongs_to :variety
  belongs_to :patron

  class << self
    def search_by_patron_and_name(p_search)
      p_el = p_search.split
      patron = nil
      if p_el.count > 0
        v_i = 0
        v_i.upto(p_el.count) do |i|
          patron = Patron.find_by(public_id: p_el[i])
          if patron.present?
            break
          end
        end
      end
      ret_patient = nil
      if patron.present?
        patron.patients.each do |patient|
          v_i = 0
          v_i.upto(p_el.count) do |i|
            if patient.name == p_el[i]
              ret_patient = patient
            end
          end
        end
      end
      ret_patient
    end
  end

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

  def name_with_patron_name
    [name, patron.id_with_last_name].compact.join(' / ')
  end

end
