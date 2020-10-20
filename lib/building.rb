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
end
