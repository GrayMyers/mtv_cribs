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

  def test_it_adds_unit
    assert_equal [], @building.units
    apartment1 = mock
    apartment2 = mock

    @building.add_unit(apartment1)
    @building.add_unit(apartment2)
    assert_equal [apartment1,apartment2], @building.units
  end

  def test_it_tracks_renters
    assert_equal [], @building.renters

    renter1 = mock
    renter2 = mock

    apartment1 = mock
    apartment1.expects(:renter).returns(renter1)

    apartment2 = mock
    apartment2.expects(:renter).returns(renter2)

    apartment3 = mock
    apartment3.expects(:renter).returns(nil)

    @building.add_unit(apartment1)
    @building.add_unit(apartment2)
    @building.add_unit(apartment3)
    assert_equal [renter1,renter2], @building.renters
  end
end
