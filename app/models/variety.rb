class Variety < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :patients

  class << self
    def search_by_name(p_search)
      p_el = p_search.split
      variety = nil
      if p_el.count > 0
        v_i = 0
        v_i.upto(p_el.count) do |i|
          variety = find_by(name: p_el[i])
          if variety.present?
            break
          end
        end
      end
      variety
    end
  end

end
