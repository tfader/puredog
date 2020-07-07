class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :spots
end
