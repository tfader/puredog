class Patron < ApplicationRecord
  validates :public_id, presence: true, uniqueness: true, length: { is: 11 }, numericality: { only_integer: true }
  validates :last_name, presence: true

  before_save :capitalize_names

  has_many :patients

  class << self
    def search_by_id_or_second(p_search)
      p_el = p_search.split
      patron = nil
      if p_el.count > 0
        v_i = 0
        v_i.upto(p_el.count) do |i|
          patron = find_by(public_id: p_el[i])
          if patron.present?
            break
          else
            patron = find_by(last_name: p_el[i])
            if patron.present?
              break
            end
          end
        end
      end
      patron
    end
  end

  def capitalize_names
    self.last_name.capitalize!
    self.first_name.capitalize!
  end

  def id_with_last_name
    [public_id, last_name].compact.join(' / ')
  end

  def id_with_names
    [public_id, last_name, first_name].compact.join(' / ')
  end

  def id_with_name
    [public_id, first_name+' '+last_name].compact.join(' / ')
  end

  def name_with_id
    [last_name+' '+first_name, public_id].compact.join(' / ')
  end

end
