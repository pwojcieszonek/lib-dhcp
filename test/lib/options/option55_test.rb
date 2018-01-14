#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require 'lib/dhcp'
require_relative '../../test_helper'

class Option55 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option55.new(1, 10, 12)
    @option_unpack = Lib::DHCP::Option.unpack([55,3,1, 10, 12].pack('C*'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def test_type
    assert_instance_of Lib::DHCP::Option55, @option
  end

  def test_to_string
    @option.payload.each do |p|
      assert_fail_assertion unless p.to_s == '1' or p.to_s == '10' or p.to_s =='12'
    end
  end

  def test_to_integer
    @option.payload.each do |p|
      assert_fail_assertion unless p.to_i == 1 or p.to_i == 10 or p.to_i == 12
    end
  end

  def test_length
    assert_equal 3, @option.len
  end

  def test_oid
    assert_equal 55, @option.oid
  end

  def test_pack
    expected = [55,3,1, 10, 12].pack('C*')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option55, @option_unpack
  end

  def test_to_string_unpack
    @option_unpack.payload.each do |p|
      assert_fail_assertion unless p.to_s == '1' or p.to_s == '10' or p.to_s =='12'
    end
  end

  def test_to_integer_unpack
    @option_unpack.payload.each do |p|
      assert_fail_assertion unless p.to_i == 1 or p.to_i == 10 or p.to_i == 12
    end
  end

  def test_oid_unpack
    assert_equal 55, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 3, @option_unpack.len
  end

end