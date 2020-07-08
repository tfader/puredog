class Spot < ApplicationRecord
  belongs_to :city
  has_many :employee2_spots
  has_many :stations

  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
  validates :street, presence: true
end
