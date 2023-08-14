#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require 'lib/dhcp'
require_relative '../../test_helper'

class Option52 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option52.new(1)
    @option_unpack = Lib::DHCP::Option.unpack([52,1,1].pack('C3'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def test_possible_argument
    assert_raises(ArgumentError) {Lib::DHCP::Option52.new(0)}
    assert_instance_of Lib::DHCP::Option52, Lib::DHCP::Option52.new(1)
    assert_instance_of Lib::DHCP::Option52, Lib::DHCP::Option52.new(2)
    assert_instance_of Lib::DHCP::Option52, Lib::DHCP::Option52.new(3)
    (4..255).each {|i| assert_raises(ArgumentError) {Lib::DHCP::Option52.new(i)}}
  end

  def test_type
    assert_instance_of Lib::DHCP::Option52, @option
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
    assert_equal 52, @option.oid
    assert_equal 52, JSON.parse(@option.to_json)['oid']
  end

  def test_pack
    expected = [52,1,1].pack('C3')
    assert_equal expected, @option.pack
  end

  def test_possible_argument_unpack
    assert_raises(ArgumentError) { Lib::DHCP::Option.unpack([52,1,0].pack('C3'))}
    assert_instance_of Lib::DHCP::Option52, Lib::DHCP::Option.unpack([52,1,1].pack('C3'))
    assert_instance_of Lib::DHCP::Option52, Lib::DHCP::Option.unpack([52,1,2].pack('C3'))
    assert_instance_of Lib::DHCP::Option52, Lib::DHCP::Option.unpack([52,1,3].pack('C3'))
    (4..255).each {|i| assert_raises(ArgumentError) { Lib::DHCP::Option.unpack([52,1,i].pack('C3'))}}
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option52, @option_unpack
  end

  def test_to_string_unpack
    assert_equal '1', @option_unpack.payload.to_s
  end

  def test_to_integer_unpack
    assert_equal 1, @option_unpack.payload.to_i
  end

  def test_oid_unpack
    assert_equal 52, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 1, @option_unpack.len
  end

end