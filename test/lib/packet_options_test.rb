#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 24.03.2016 by Piotr Wojcieszonek

require_relative '../test_helper'

class Options < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @options = Lib::DHCP::Options.new([53,1],[1, '255.255.255.0'])
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def test_respond_to_options
    assert_respond_to @options, :options
  end

  def test_respond_to_pack
    assert_respond_to @options, :pack
  end

  def test_respond_to_add
    assert_respond_to @options, :add
  end

  def test_respond_to_each
    assert_respond_to @options, :each
  end

  def test_respond_to_map
    assert_respond_to @options, :map
  end

  def test_respond_to_map!
    assert_respond_to @options, :map!
  end

  def test_respond_to_select
    assert_respond_to @options, :select
  end

  def test_respond_to_array_key
    assert_respond_to @options, :[]
  end

  def test_respond_to_array_key=
    assert_respond_to @options, :[]=
  end

  def test_respond_to_del
    assert_respond_to @options, :del
  end

  def test_respond_to_shift
    assert_respond_to @options, :<<
  end


  def test_new
    assert_instance_of Lib::DHCP::Options, @options
  end

  def test_unpack
    options = Lib::DHCP::Options.new
    options << [53,1,1].pack('C3')
    assert_equal Lib::DHCP::Option53.new(1).to_i, options.select(53).first.to_i
  end

  def test_pack
    packed = [53,1,1,1,4,4294967040].pack('C5N')
    assert_equal packed, @options.pack
  end

  def test_add
    options = Lib::DHCP::Options.new
    option53 = Lib::DHCP::Option53.new(1)
    options.add option53
    assert_equal option53, options.select(53).first
  end

  def test_each
    @options.each{ |option| assert_kind_of Lib::DHCP::Option, option}
    options = @options.each
    assert_instance_of Enumerator, options
    options.each{|option| assert_kind_of Lib::DHCP::Option, option}
  end

  def test_map
    options = @options.map do |option|
      option.value = 2 if option.oid == 53
      option
    end
    assert_equal 2, options[0].to_i
  end

  def test_map!
    options = Lib::DHCP::Options.new([53,1],[1, '255.255.255.0'])
    options.map! do |option|
      option.value = 2 if option.oid == 53
      option
    end
    assert_equal 2, options.select(53).first.to_i
  end

  def test_select
    assert_equal 1, @options.select(53).first.to_i
  end

  def test_array_key
    assert_equal 1, @options[0].to_i
  end

  def test_array_key=
    options = Lib::DHCP::Options.new([53,1],[1, '255.255.255.0'])
    options[0]= Lib::DHCP::Option53.new(2)
    assert_equal 2, options[0].to_i
  end

  def test_del
    options = Lib::DHCP::Options.new([53,1],[1, '255.255.255.0'])
    options.del 53
    assert_nil options.select(53).first
  end

  def test_options
    assert_kind_of Array, @options.options
    @options.options.each{|option| assert_kind_of Lib::DHCP::Option, option}
  end

end