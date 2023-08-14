#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'
require 'lib/dhcp'

class Option10 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option10.new('10.0.0.1,127.0.0.1')
    @option_unpack = Lib::DHCP::Option.unpack([10,8,167772161, 2130706433].pack('C2N2'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.


  def test_type
    assert_instance_of Lib::DHCP::Option10, @option
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

  def test_to_json
    JSON.parse(@option.to_json)['value'].each do |opt|
      assert_fail_assertion unless opt['address'] == '10.0.0.1' or opt['address'] == '127.0.0.1'
      assert_fail_assertion unless opt['mask'] == '255.255.255.255' or opt['mask'] == '255.255.255.255'
      assert_fail_assertion unless opt['broadcast'] == '10.0.0.1' or opt['broadcast'] == '127.0.0.1'
      assert_fail_assertion unless opt['net'] == '10.0.0.1' or opt['net'] == '127.0.0.1'
      assert_fail_assertion unless opt['cidr'] == '10.0.0.1/32' or opt['cidr'] == '127.0.0.1/32'
    end
  end

  def test_length
    assert_equal 8, @option.len
    assert_equal 8, JSON.parse(@option.to_json)['len']
  end

  def test_oid
    assert_equal 10, @option.oid
    assert_equal 10, JSON.parse(@option.to_json)['oid']
  end

  def test_pack
    expected = [10,8,167772161, 2130706433].pack('C2N2')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option10, @option_unpack
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
    assert_equal 10, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 8, @option_unpack.len
  end
end