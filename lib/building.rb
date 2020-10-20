class Building
  attr_reader :units
  def initialize
    @units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    renter_array = @units.filter{|unit| unit.renter} #removes units with no renter

    renter_array.map do |unit|
      unit.renter.name
    end
  end

  def average_rent
    total_rent = @units.sum do |unit|
      unit.monthly_rent
    end
    if @units.length > 0
      total_rent.to_f/@units.length.to_f
    else
      0 #dividing by zero is bad
    end
  end

  def rented_units
    @units.filter{|unit| unit.renter} #removes units with no renter
  end

  def renter_with_highest_rent
    highest_rented = rented_units.max_by{|unit| unit.monthly_rent}
    if highest_rented
      highest_rented.renter
    else
      nil
    end
  end

  def units_by_number_of_bedrooms
    return_hash = @units.group_by do |unit|
      unit.bedrooms
    end
    return_hash.map do |key,value|
      value.map do |unit|
        unit.number
      end
    end
    return_hash
  end

  def annual_breakdown
    return_hash = {}
    rented_units.each do |unit|
      return_hash[unit.renter.name] = unit.monthly_rent * 12
    end
    return_hash
  end

  def rooms_by_renter
    return_hash = {}
    rented_units.each do |unit|
      room_info_hash = {
        bathrooms: unit.bathrooms,
        bedrooms: unit.bedrooms
      }
      return_hash[unit.renter] = room_info_hash
    end
    return_hash
  end
end
