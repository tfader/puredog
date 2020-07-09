class Client < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  belongs_to :city
  has_many :price_lists

  class << self
    def search_by_id_or_second(p_search)
      p_el = p_search.split
      client = nil
      if p_el.count > 0
        v_i = 0
        v_i.upto(p_el.count) do |i|
          client = find_by(code: p_el[i])
          if client.present?
            break
          else
            client = find_by(name: p_el[i])
            if client.present?
              break
            end
          end
        end
      end
      client
    end
  end

  def address_name
    [city.name, street].compact.join(' / ')
  end

  def name_with_city
    [code, name, city.name].compact.join(' / ')
  end

end
