class AttrClass < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :attrs

end
