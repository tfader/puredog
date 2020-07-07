class Employee < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  has_one :employee_user
  has_many :employee_spots

  def first_second_name
    [first_name, second_name].compact.join(', ')
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def current_spot(p_date = DateTime.now)
    if employee_spots.present?
      employee_spots.where('? between date_from and date_to', p_date).first.spot.name
    else
      nil
    end
  end

end
