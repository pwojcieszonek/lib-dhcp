#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'
require 'lib/dhcp'

class Option59 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option59.new(11214)
    @option_unpack = Lib::DHCP::Option.unpack([59,4,11214].pack('C2N'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.


  def test_type
    assert_instance_of Lib::DHCP::Option59, @option
  end

  def test_to_string
    assert_equal '11214', @option.payload.to_s
  end

  def test_to_integer
    assert_equal 11214, @option.payload.to_i
  end


  def test_length
    assert_equal 4, @option.len
  end

  def test_oid
    assert_equal 59, @option.oid
  end

  def test_pack
    expected = [59,4,11214].pack('C2N')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option59, @option_unpack
  end

  def test_to_string_unpack
    assert_equal '11214', @option_unpack.payload.to_s
  end

  def test_to_integer_unpack
    assert_equal 11214 , @option_unpack.payload.to_i
  end

  def test_oid_unpack
    assert_equal 59, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 4, @option_unpack.len
  end
end