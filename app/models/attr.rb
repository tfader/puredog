class Attr < ApplicationRecord
  validates :name, presence: true
  validates :attr_class, presence: true

  belongs_to :attr_class
  has_many :patient_attrs
  has_many :patient_attr_values

  def attr_value_type
    if value_type == 1
      'Tekst'
      else if value_type == 2
             'Liczba'
           else
             'Data'
           end
    end
  end

  def name_with_class_name
      [attr_class.name, name].compact.join(' - ')
  end
end
