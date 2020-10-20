class Building
  attr_reader :units
  def initialize
    @units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    renter_array = @units.map do |unit|
      unit.renter
    end
    renter_array.filter{|renter| renter} #removes nil elements
  end

  def average_rent
    total_rent = @units.sum do |unit|
      unit.monthly_rent
    end
    if @units.length > 0
      total_rent/units.length
    else
      0
    end
  end
end
