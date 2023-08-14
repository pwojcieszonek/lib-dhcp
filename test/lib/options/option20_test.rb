#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'
require 'lib/dhcp'

class Option20 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option20.new(1)
    @option_unpack = Lib::DHCP::Option.unpack([20,1,1].pack('C3'))
  end


  def test_type
    assert_instance_of Lib::DHCP::Option20, @option
  end

  def test_to_string
    assert_equal '1', @option.payload.to_s
  end

  def test_to_integer
    assert_equal 1, @option.payload.to_i
  end

  def test_to_json
    assert_equal 1, JSON.parse(@option.to_json)['value']
  end

  def test_length
    assert_equal 1, @option.len
    assert_equal 1, JSON.parse(@option.to_json)['len']
  end

  def test_oid
    assert_equal 20, @option.oid
    assert_equal 20, JSON.parse(@option.to_json)['oid']
  end

  def test_pack
    expected = [20,1,1].pack('C3')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option20, @option_unpack
  end

  def test_to_string_unpack
    assert_equal '1', @option_unpack.payload.to_s
  end

  def test_to_integer_unpack
    assert_equal 1, @option_unpack.payload.to_i
  end

  def test_oid_unpack
    assert_equal 20, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 1, @option_unpack.len
  end
end