#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.02.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'
require 'lib/dhcp'

class Option61 < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @option  = Lib::DHCP::Option61.new('01001122334455')
    payload ='01001122334455'
    op61 = [payload.to_s.gsub(/(:|-|\.|,)/,'').to_s].pack('H*').unpack('C*')
    @option_unpack = Lib::DHCP::Option.unpack([61,7,op61.map{|item| item.to_s(16).rjust(2,'0')}.join('')].pack('C2H*'))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.


  def test_type
    assert_instance_of Lib::DHCP::Option61, @option
  end

  def test_to_string
    assert_equal '01001122334455', @option.payload.to_s
  end


  def test_length
    assert_equal 7, @option.len
  end

  def test_oid
    assert_equal 61, @option.oid
  end

  def test_pack
    payload ='01001122334455'
    op61 = [payload.to_s.gsub(/(:|-|\.|,)/,'').to_s].pack('H*').unpack('C*')
    expected = [61,7,op61.map{|item| item.to_s(16).rjust(2,'0')}.join('')].pack('C2H*')
    assert_equal expected, @option.pack
  end

  def test_type_unpack
    assert_instance_of Lib::DHCP::Option61, @option_unpack
  end

  def test_to_string_unpack
    assert_equal '01001122334455', @option_unpack.payload.to_s
  end



  def test_oid_unpack
    assert_equal 61, @option_unpack.oid
  end

  def test_length_unpack
    assert_equal 7, @option_unpack.len
  end
end