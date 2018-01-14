#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'


class Option3 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option3.new('10.0.0.1,127.0.0.1')
    @option_unpack = Lib::DHCP::Option.unpack([3,8,167772161, 2130706433].pack('C2N2'))
  end

  def test_type
    assert_instance_of Lib::DHCP::Option3, @option
  end

  def test_to_string
    @option.payload.each do |ip|
      assert_fail_assertion unless ip.to_s =='10.0.0.1' or ip.to_s == '127.0.0.1'
    end
  end

  def test_to_integer
    @option.payload.each do |ip|
      assert_fail_assertion unless ip.to_i == 167772161 or ip.to_i == 2130706433
    end
  end

  def test_length
    assert_equal 8, @option.len
  end

  def test_oid
    assert_equal 3, @option.oid
  end

  def test_pack
    expected = [3,8,167772161, 2130706433].pack('C2N2')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option3, @option_unpack
  end

  def test_to_string_unpack
    @option_unpack.payload.each do |ip|
      assert_fail_assertion unless ip.to_s =='10.0.0.1' or ip.to_s == '127.0.0.1'
    end
  end

  def test_to_integer_unpack
    @option_unpack.payload.each do |ip|
      assert_fail_assertion unless ip.to_i == 167772161 or ip.to_i == 2130706433
    end
  end

  def test_oid_unpack
    assert_equal 3, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 8, @option_unpack.len
  end

end