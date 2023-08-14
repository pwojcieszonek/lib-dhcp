#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'
require 'lib/dhcp'

class Option18 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option18.new('/test/ext/path/')
    @option_unpack = Lib::DHCP::Option.unpack([18,15,'/test/ext/path/'].pack('C2a15'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.


  def test_type
    assert_instance_of Lib::DHCP::Option18, @option
  end

  def test_to_string
    assert_equal '/test/ext/path/', @option.payload.to_s
  end

  def test_to_json
    assert_equal '/test/ext/path/', JSON.parse(@option.to_json)['value']
  end

  def test_length
    assert_equal 15, @option.len
    assert_equal 15, JSON.parse(@option.to_json)['len']
  end

  def test_oid
    assert_equal 18, @option.oid
    assert_equal 18, JSON.parse(@option.to_json)['oid']
  end

  def test_pack
    expected = [18,15,'/test/ext/path/'].pack('C2a15')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option18, @option_unpack
  end

  def test_to_string_unpack
    assert_equal '/test/ext/path/', @option_unpack.payload.to_s
  end



  def test_oid_unpack
    assert_equal 18, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 15, @option_unpack.len
  end
end