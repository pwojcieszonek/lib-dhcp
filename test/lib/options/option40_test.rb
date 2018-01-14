#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'
require 'lib/dhcp'

class Option40 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option40.new('nis.example.com')
    @option_unpack = Lib::DHCP::Option.unpack([40,15,'nis.example.com'].pack('C2a15'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.


  def test_type
    assert_instance_of Lib::DHCP::Option40, @option
  end

  def test_to_string
    assert_equal 'nis.example.com', @option.payload.to_s
  end


  def test_length
    assert_equal 15, @option.len
  end

  def test_oid
    assert_equal 40, @option.oid
  end

  def test_pack
    expected = [40,15,'nis.example.com'].pack('C2a15')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option40, @option_unpack
  end

  def test_to_string_unpack
    assert_equal 'nis.example.com', @option_unpack.payload.to_s
  end



  def test_oid_unpack
    assert_equal 40, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 15, @option_unpack.len
  end
end