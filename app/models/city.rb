class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :spots
  has_many :clients

  class << self
    def search_by_name(p_search)
      p_el = p_search.split
      city = nil
      if p_el.count > 0
        v_i = 0
        v_i.upto(p_el.count) do |i|
          city = find_by(name: p_el[i])
          if city.present?
            break
          end
        end
      end
      city
    end
  end

end
