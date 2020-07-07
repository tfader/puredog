class UnitRate < ApplicationRecord
  belongs_to :from_unit, :class_name => 'Unit'
  belongs_to :to_unit, :class_name => 'Unit'
end
