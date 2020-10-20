require "minitest/autorun"
require 'minitest/pride'
require "mocha/minitest"
require "./lib/building.rb"

class ApartmentTest < Minitest::Test
  def setup
    # @unit1 = Apartment.new({
    #   number: "A1",
    #   monthly_rent: 1200,
    #   bathrooms: 1,
    #   bedrooms: 1
    # })
    @building = Building.new
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Building, @building

    assert_equal [], @building.units
  end

end
