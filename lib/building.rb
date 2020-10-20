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
      total_rent/units.length
    else
      0 #dividing by zero is bad
    end
  end
end
