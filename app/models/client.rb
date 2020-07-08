class Client < ApplicationRecord
  belongs_to :city

  def address_name
    [city.name, street].compact.join(' / ')
  end

end
