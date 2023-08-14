#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 23.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'
require 'lib/dhcp'


class Option255 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option255.new
    @option_unpack = Lib::DHCP::Option.unpack( [255,0].pack('C2') )
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.


  def test_type
    assert_kind_of Lib::DHCP::Option255, @option
    assert_kind_of Lib::DHCP::Option255, @option_unpack
  end

  def test_len
    assert_equal 0, @option.len
    assert_equal 0, @option_unpack.len
    assert_equal 0, JSON.parse(@option.to_json)['len']
  end

  def test_oid
    assert_equal 255, @option.oid
    assert_equal 255, @option_unpack.oid
    assert_equal 255, JSON.parse(@option.to_json)['oid']
  end


end