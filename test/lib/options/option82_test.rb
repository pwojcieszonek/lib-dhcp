#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.02.2016 by Piotr Wojcieszonek

require_relative '../../test_helper'
require 'lib/dhcp'

class Option82 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option82.new([1, 'circuit-id'],[2, 'remote-id'])
    @option_unpack = Lib::DHCP::Option.unpack([82,23, 1, 10, 'circuit-id', 2, 9, 'remote-id'].pack('C4a10C2a9'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def test_type
    assert_instance_of Lib::DHCP::Option82, @option
  end

  def test_to_string
    #suboption 1
    assert_equal 'circuit-id', @option.option1.payload.to_s
    #suboption 3
    assert_equal 'remote-id', @option.option2.payload.to_s
  end

  def test_to_json
    assert_equal [{ "name" => "DHCP SubOption1", "oid" => 1, "len" => 10, "value" => "circuit-id" },
                  { "name" => "DHCP SubOption2", "oid" => 2, "len" => 9, "value" => "remote-id" }],
                 JSON.parse(@option.to_json)['value']
  end

  def test_length
    assert_equal 23, @option.len
    #suboption 1
    assert_equal 10, @option.option1.len
    #suboption 1
    assert_equal 9, @option.option2.len
  end

  def test_oid
    assert_equal 82, @option.oid
  end

  def test_pack
    #[option oid, option len, supotion oid, suboption len, suboption value]
    expected = [82,23, 1, 10, 'circuit-id', 2, 9, 'remote-id'].pack('C4a10C2a9')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option82, @option_unpack
  end

  def test_to_string_unpack
    #suboption 1
    assert_equal 'circuit-id', @option_unpack.option1.payload.to_s
    #suboption 2
    assert_equal 'remote-id', @option_unpack.option2.payload.to_s
  end

  def test_oid_unpack
    assert_equal 82, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 23, @option_unpack.len
    #suboption 1
    assert_equal 10, @option_unpack.option1.len
    #suboption 2
    assert_equal 9, @option_unpack.option2.len
  end

end