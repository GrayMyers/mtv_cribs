require "minitest/autorun"
require 'minitest/pride'
require "./lib/renter.rb"

class RenterTest < Minitest::Test
  def setup
    @renter = Renter.new("Jessie")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Renter, @renter

    assert_equal "Jessie", @renter.name
  end
end
