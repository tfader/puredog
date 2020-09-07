class Parameter < ApplicationRecord
  validates :param_name, presence: true, uniqueness: true
  validates :param_value, presence: true
  validates :value_type, presence: true

  class << self
    def get_value(p_parameter_name)
      parameter = find_by(param_name: p_parameter_name)
      if parameter.present?
        if parameter.value_type == '1'
          parameter.param_value
        else
          if parameter.value_type == '2'
            parameter.param_value.to_i
          else
            if parameter.value_type == '3'
              parameter.param_value.to_date
            else
              -1
            end
          end
        end
      else
        '-1'
      end
    end
  end

  def value_type_desc
    if value_type == '1'
      'String'
    else
      if value_type == '2'
        'Number'
      else
        'Date'
      end
    end

  end
end
