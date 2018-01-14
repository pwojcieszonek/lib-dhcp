#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'
require 'lib/dhcp'

class Option15 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option15.new('example.com')
    @option_unpack = Lib::DHCP::Option.unpack([15,11,'example.com'].pack('C2a11'))
  end

  def test_type
    assert_instance_of Lib::DHCP::Option15, @option
  end

  def test_to_string
    assert_equal 'example.com', @option.payload.to_s
  end


  def test_length
    assert_equal 11, @option.len
  end

  def test_oid
    assert_equal 15, @option.oid
  end

  def test_pack
    expected = [15,11,'example.com'].pack('C2a11')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option15, @option_unpack
  end

  def test_to_string_unpack
    assert_equal 'example.com', @option_unpack.payload.to_s
  end



  def test_oid_unpack
    assert_equal 15, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 11, @option_unpack.len
  end
end