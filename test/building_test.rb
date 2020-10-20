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
    #used stubs here because these can be called multiple times
    #under normal circumstances
    apartment1 = mock
    apartment1.stubs(:renter).returns(renter1)

    apartment2 = mock
    apartment2.stubs(:renter).returns(renter2)

    apartment3 = mock
    apartment3.stubs(:renter).returns(nil)

    @building.add_unit(apartment1)
    @building.add_unit(apartment2)
    @building.add_unit(apartment3)
    assert_equal [renter1,renter2], @building.renters
  end

  def test_it_has_average_rent
    assert_equal 0, @building.average_rent
    apartment1 = mock
    apartment1.expects(:monthly_rent).returns(500)

    apartment2 = mock
    apartment2.expects(:monthly_rent).returns(1000)

    apartment3 = mock
    apartment3.expects(:monthly_rent).returns(1500)

    @building.add_unit(apartment1)
    @building.add_unit(apartment2)
    @building.add_unit(apartment3)
    assert_equal 1000, @building.average_rent
  end

  def test_it_tracks_rented_units
    assert_equal [], @building.units
    apartment1 = mock
    apartment2 = mock

    @building.add_unit(apartment1)
    @building.add_unit(apartment2)
    assert_equal [apartment1,apartment2], @building.units
  end

  def test_it_tracks_renters
    assert_equal [], @building.rented_units

    renter1 = mock
    renter2 = mock
    #used stubs here because these can be called multiple times
    #under normal circumstances
    apartment1 = mock
    apartment1.stubs(:renter).returns(renter1)

    apartment2 = mock
    apartment2.stubs(:renter).returns(renter2)

    apartment3 = mock
    apartment3.stubs(:renter).returns(nil)

    @building.add_unit(apartment1)
    @building.add_unit(apartment2)
    @building.add_unit(apartment3)
    assert_equal [apartment1,apartment2], @building.rented_units

  end
end
