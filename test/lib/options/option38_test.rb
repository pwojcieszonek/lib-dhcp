#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'
require 'lib/dhcp'

class Option38 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option38.new(112)
    @option_unpack = Lib::DHCP::Option.unpack([38,4,112].pack('C2N'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.


  def test_type
    assert_instance_of Lib::DHCP::Option38, @option
  end

  def test_to_string
    assert_equal '112', @option.payload.to_s
  end

  def test_to_integer
    assert_equal 112, @option.payload.to_i
  end

  def test_to_json
    assert_equal 112, JSON.parse(@option.to_json)['value']
  end

  def test_length
    assert_equal 4, @option.len
    assert_equal 4, JSON.parse(@option.to_json)['len']
  end

  def test_oid
    assert_equal 38, @option.oid
    assert_equal 38, JSON.parse(@option.to_json)['oid']
  end

  def test_pack
    expected = [38,4,112].pack('C2N')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option38, @option_unpack
  end

  def test_to_string_unpack
    assert_equal '112', @option_unpack.payload.to_s
  end

  def test_to_integer_unpack
    assert_equal 112 , @option_unpack.payload.to_i
  end

  def test_oid_unpack
    assert_equal 38, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 4, @option_unpack.len
  end
end