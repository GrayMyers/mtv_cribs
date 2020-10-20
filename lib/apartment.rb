class Apartment
  attr_reader :number, :monthly_rent, :bathrooms, :bedrooms, :renter
  def initialize(info_hash)
    @number = info_hash[:number]
    @monthly_rent = info_hash[:monthly_rent]
    @bathrooms = info_hash[:bathrooms]
    @bedrooms = info_hash[:bedrooms]
  end
end
