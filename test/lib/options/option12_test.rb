#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'
require 'lib/dhcp'

class Option12 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option12.new('host_name.example.com')
    @option_unpack = Lib::DHCP::Option.unpack([12,21,'host_name.example.com'].pack('C2a21'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.


  def test_type
    assert_instance_of Lib::DHCP::Option12, @option
  end

  def test_to_string
    assert_equal 'host_name.example.com', @option.payload.to_s
  end

  def test_to_json
    assert_equal 'host_name.example.com', JSON.parse(@option.to_json)['value']
  end

  def test_length
    assert_equal 21, @option.len
    assert_equal 21, JSON.parse(@option.to_json)['len']
  end

  def test_oid
    assert_equal 12, @option.oid
    assert_equal 12, JSON.parse(@option.to_json)['oid']
  end

  def test_pack
    expected = [12,21,'host_name.example.com'].pack('C2a21')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option12, @option_unpack
  end

  def test_to_string_unpack
    assert_equal 'host_name.example.com', @option_unpack.payload.to_s
  end



  def test_oid_unpack
    assert_equal 12, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 21, @option_unpack.len
  end
end