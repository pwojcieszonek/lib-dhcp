#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 25.03.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'

class Discover < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @discover = Lib::DHCP::Message::Discover.new(chaddr: '00:11:22:33:44:55', xid: 1374095120)
    @from_json = Lib::DHCP::Message::Discover.from_json @discover.to_json
  end

  def test_to_json
    json = { "op" => { "code" => "1", "name" => "BOOTREQUEST" },
             "htype" => { "code" => "1", "name" => "Ethernet (10Mb)" },
             "hlen" => "6",
             "hops" => "0",
             "xid" => "1374095120",
             "secs" => "0",
             "flags" => "0x0",
             "ciaddr" =>
               { "address" => "0.0.0.0",
                 "mask" => "255.255.255.255",
                 "net" => "0.0.0.0",
                 "broadcast" => "0.0.0.0",
                 "cidr" => "0.0.0.0/32" },
             "yiaddr" =>
               { "address" => "0.0.0.0",
                 "mask" => "255.255.255.255",
                 "net" => "0.0.0.0",
                 "broadcast" => "0.0.0.0",
                 "cidr" => "0.0.0.0/32" },
             "siaddr" =>
               { "address" => "0.0.0.0",
                 "mask" => "255.255.255.255",
                 "net" => "0.0.0.0",
                 "broadcast" => "0.0.0.0",
                 "cidr" => "0.0.0.0/32" },
             "giaddr" =>
               { "address" => "0.0.0.0",
                 "mask" => "255.255.255.255",
                 "net" => "0.0.0.0",
                 "broadcast" => "0.0.0.0",
                 "cidr" => "0.0.0.0/32" },
             "chaddr" => "00:11:22:33:44:55:00:00:00:00:00:00:00:00:00:00",
             "sname" => ".",
             "file" => ".",
             "options" => [{ "name" => "DHCP Message Type", "oid" => 53, "len" => 1, "value" => 1 }] }
    assert_equal json, JSON.parse(@discover.to_json)
  end

  def test_message_type
    assert_equal 1, @discover.option53.to_i
    assert_equal 1, @from_json.option53.to_i
  end

  def test_op_code
    assert_equal 1, @discover.op.to_i
    assert_equal 1, @from_json.op.to_i
  end

  def test_sanity_check
    assert_nil  @discover.send(:sanity_check)
    assert_nil @from_json.send(:sanity_check)
  end

  def test_sanity_check_yiaddr
    discover = @discover.dup
    discover.yiaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Discover do
      discover.send(:sanity_check)
    end

    discover = @from_json.dup
    discover.yiaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Discover do
      discover.send(:sanity_check)
    end
  end

  def test_sanity_check_ciaddr
    discover = @discover.dup
    discover.ciaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Discover do
      discover.send(:sanity_check)
    end

    discover = @from_json.dup
    discover.ciaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Discover do
      discover.send(:sanity_check)
    end
  end

  def test_sanity_check_option54
    discover = @discover.dup
    discover.options.add Lib::DHCP::Option54.new('10.0.0.1')
    assert_raises Lib::DHCP::SanityCheck::Discover do
      discover.send(:sanity_check)
    end

    discover = @from_json.dup
    discover.options.add Lib::DHCP::Option54.new('10.0.0.1')
    assert_raises Lib::DHCP::SanityCheck::Discover do
      discover.send(:sanity_check)
    end
  end

  def test_pack

    packed = Lib::BOOTP::Packet.new(op:1 , chaddr: '00:11:22:33:44:55', xid: @discover.xid).pack
    packed += [0x63825363.to_i].pack('N')
    packed += [53,1,1].pack('C3')
    packed += [255].pack('C')
    (1..60).each do
      packed += [0].pack('C')
    end
    assert_equal packed, @discover.pack
    assert_equal packed, @from_json.pack
  end


end