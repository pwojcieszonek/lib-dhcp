#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'
require 'lib/dhcp'

class Option23 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option23.new(112)
    @option_unpack = Lib::DHCP::Option.unpack([23,1,112].pack('C3'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.


  def test_type
    assert_instance_of Lib::DHCP::Option23, @option
  end

  def test_to_string
    assert_equal '112', @option.payload.to_s
  end

  def test_to_integer
    assert_equal 112, @option.payload.to_i
  end


  def test_length
    assert_equal 1, @option.len
  end

  def test_oid
    assert_equal 23, @option.oid
  end

  def test_pack
    expected = [23,1,112].pack('C3')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option23, @option_unpack
  end

  def test_to_string_unpack
    assert_equal '112', @option_unpack.payload.to_s
  end

  def test_to_integer_unpack
    assert_equal 112 , @option_unpack.payload.to_i
  end

  def test_oid_unpack
    assert_equal 23, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 1, @option_unpack.len
  end
end