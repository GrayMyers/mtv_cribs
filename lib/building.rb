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
      unit.renter
    end
  end

  def average_rent
    total_rent = @units.sum do |unit|
      unit.monthly_rent
    end
    if @units.length > 0
      total_rent/@units.length
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
    @units.group_by do |unit|
      unit.bedrooms
    end
  end
end
