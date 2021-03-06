require "minitest/autorun"
require 'minitest/pride'
require "mocha/minitest"
require "./lib/apartment.rb"

class ApartmentTest < Minitest::Test
  def setup
    @unit1 = Apartment.new({
      number: "A1",
      monthly_rent: 1200,
      bathrooms: 1,
      bedrooms: 1
    })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Apartment, @unit1

    assert_equal "A1", @unit1.number
    assert_equal 1200, @unit1.monthly_rent
    assert_equal 1, @unit1.bathrooms
    assert_equal 1, @unit1.bedrooms
    assert_equal nil, @unit1.renter
  end

  def test_it_adds_renter
    assert_equal nil, @unit1.renter
    renter = mock
    @unit1.add_renter(renter)
    assert_equal renter, @unit1.renter
  end
end
