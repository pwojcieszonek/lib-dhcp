#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.02.2016 by Piotr Wojcieszonek

require_relative '../../test_helper'
require 'lib/dhcp'

class Option43 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option43.new([1, 'http://acs.example.com/acs'])
    @option_unpack = Lib::DHCP::Option.unpack([43,28, 1, 26, 'http://acs.example.com/acs'].pack('C4a26'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def test_type
    assert_instance_of Lib::DHCP::Option43, @option
  end

  def test_to_string
    #suboption 1
    assert_equal 'http://acs.example.com/acs', @option.option1.payload.to_s
  end

  def test_length
    assert_equal 28, @option.len
    #suboption 1
    assert_equal 26, @option.option1.len
  end

  def test_oid
    assert_equal 43, @option.oid
  end

  def test_pack
    #[option oid, option len, supotion oid, suboption len, suboption value]
    expected = [43,28,1,26, 'http://acs.example.com/acs'].pack('C4a26')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option43, @option_unpack
  end

  def test_to_string_unpack
    #suboption 1
    assert_equal 'http://acs.example.com/acs', @option_unpack.option1.payload.to_s
  end

  def test_oid_unpack
    assert_equal 43, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 28, @option_unpack.len
    #suboption 1
    assert_equal 26, @option_unpack.option1.len
  end

end