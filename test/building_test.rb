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
    renter1.stubs(:name).returns("Jessie")
    renter2 = mock
    renter2.stubs(:name).returns("Jessie")
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
    assert_equal [renter1.name,renter2.name], @building.renters
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
    assert_equal 1000.0, @building.average_rent
  end

  def test_it_tracks_units
    assert_equal [], @building.units
    apartment1 = mock
    apartment2 = mock

    @building.add_unit(apartment1)
    @building.add_unit(apartment2)
    assert_equal [apartment1,apartment2], @building.units
  end

  def test_it_tracks_rented_units
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

  def test_it_tracks_renter_with_highest_rent
    assert_equal nil, @building.renter_with_highest_rent
    renter1 = mock
    renter2 = mock
    #used stubs here because these can be called multiple times
    #under normal circumstances
    apartment1 = mock
    apartment1.stubs(:renter).returns(renter1)
    apartment1.stubs(:monthly_rent).returns(1000)

    apartment2 = mock
    apartment2.stubs(:renter).returns(renter2)
    apartment2.stubs(:monthly_rent).returns(500)

    apartment3 = mock
    apartment3.stubs(:renter).returns(nil)
    apartment3.stubs(:monthly_rent).returns(1500)

    @building.add_unit(apartment1)
    @building.add_unit(apartment2)
    @building.add_unit(apartment3)
    assert_equal renter1, @building.renter_with_highest_rent
  end

  def test_it_sorts_units_by_number_of_bedrooms
    assert_equal Hash.new, @building.units_by_number_of_bedrooms
    renter1 = mock
    renter2 = mock
    #used stubs here because these can be called multiple times
    #under normal circumstances
    apartment1 = mock
    apartment1.stubs(:renter).returns(renter1)
    apartment1.stubs(:bedrooms).returns(2)
    apartment1.stubs(:number).returns("A1")

    apartment2 = mock
    apartment2.stubs(:renter).returns(renter2)
    apartment2.stubs(:bedrooms).returns(2)
    apartment2.stubs(:number).returns("B2")


    apartment3 = mock
    apartment3.stubs(:renter).returns(nil)
    apartment3.stubs(:bedrooms).returns(1)
    apartment3.stubs(:number).returns("C1")


    @building.add_unit(apartment1)
    @building.add_unit(apartment2)
    @building.add_unit(apartment3)
    expected_hash = { #not working
      2 => ["A1","B2"],
      1 => ["C1"]
    }
    expected_hash_actual = { #not working
      2 => [apartment1,apartment2],
      1 => [apartment3]
    }
    assert_equal expected_hash_actual, @building.units_by_number_of_bedrooms
  end

  def test_it_has_annual_breakdown
    assert_equal Hash.new, @building.annual_breakdown
    renter1 = mock
    renter1.stubs(:name).returns("Jessie")
    renter2 = mock
    renter2.stubs(:name).returns("Tim")
    #used stubs here because these can be called multiple times
    #under normal circumstances
    apartment1 = mock
    apartment1.stubs(:renter).returns(renter1)
    apartment1.stubs(:monthly_rent).returns(1000)

    apartment2 = mock
    apartment2.stubs(:renter).returns(renter2)
    apartment2.stubs(:monthly_rent).returns(500)

    apartment3 = mock
    apartment3.stubs(:renter).returns(nil)
    apartment3.stubs(:monthly_rent).returns(2000)

    @building.add_unit(apartment1)
    @building.add_unit(apartment2)
    @building.add_unit(apartment3)
    expected_hash = {
      "Jessie" => 12000,
      "Tim" => 6000
    }
    assert_equal expected_hash, @building.annual_breakdown
  end

  def test_it_sorts_rooms_by_renter
    assert_equal Hash.new, @building.rooms_by_renter
    renter1 = mock("r1")
    renter2 = mock("r2")
    #used stubs here because these can be called multiple times
    #under normal circumstances
    apartment1 = mock("apt1")
    apartment1.stubs(:bedrooms).returns(2)
    apartment1.stubs(:bathrooms).returns(3)
    apartment1.stubs(:renter).returns(renter1)
    apt1_hash = {
      bedrooms: 2,
      bathrooms: 3
    }
    apartment2 = mock("apt2")
    apartment2.stubs(:bedrooms).returns(1)
    apartment2.stubs(:bathrooms).returns(1)
    apartment2.stubs(:renter).returns(renter2)
    apt2_hash = {
      bedrooms: 1,
      bathrooms: 1
    }

    apartment3 = mock("apt3")
    apartment3.stubs(:renter).returns(nil)


    @building.add_unit(apartment1)
    @building.add_unit(apartment2)
    @building.add_unit(apartment3)

    expected_hash = {
      renter1 => apt1_hash,
      renter2 => apt2_hash
    }
    assert_equal expected_hash, @building.rooms_by_renter
  end
end
