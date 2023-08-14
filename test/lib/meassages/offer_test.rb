#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 25.03.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'

class Offer < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    options = []
    options << Lib::DHCP::Option51.new(3600)
    options << Lib::DHCP::Option54.new('10.0.0.2')
    @offer = Lib::DHCP::Message::Offer.new(chaddr: '00:11:22:33:44:55', yiaddr: '10.0.0.1', options: options, xid: 3881324093)
    @from_json = Lib::DHCP::Message::Offer.from_json @offer.to_json
  end

  def test_to_json
    json = { "op" => { "code" => "2", "name" => "BOOTREPLY" },
             "htype" => { "code" => "1", "name" => "Ethernet (10Mb)" },
             "hlen" => "6",
             "hops" => "0",
             "xid" => "3881324093",
             "secs" => "0",
             "flags" => "0x0",
             "ciaddr" =>
               { "address" => "0.0.0.0",
                 "mask" => "255.255.255.255",
                 "net" => "0.0.0.0",
                 "broadcast" => "0.0.0.0",
                 "cidr" => "0.0.0.0/32" },
             "yiaddr" =>
               { "address" => "10.0.0.1",
                 "mask" => "255.255.255.255",
                 "net" => "10.0.0.1",
                 "broadcast" => "10.0.0.1",
                 "cidr" => "10.0.0.1/32" },
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
             "options" =>
               [{ "name" => "IP Address Lease Time", "oid" => 51, "len" => 4, "value" => 3600 },
                { "name" => "Server Identifier",
                  "oid" => 54,
                  "len" => 4,
                  "value" =>
                    { "address" => "10.0.0.2",
                      "mask" => "255.255.255.255",
                      "net" => "10.0.0.2",
                      "broadcast" => "10.0.0.2",
                      "cidr" => "10.0.0.2/32" } },
                { "name" => "DHCP Message Type", "oid" => 53, "len" => 1, "value" => 2 }] }
    assert_equal json, JSON.parse(@offer.to_json)
  end

  def test_sanity_check
    assert_nil  @offer.send(:sanity_check)
    assert_nil @from_json.send(:sanity_check)
  end

  def test_message_type
    assert_equal 2, @offer.option53.to_i
    assert_equal 2, @from_json.option53.to_i
  end

  def test_op_code
    assert_equal 2, @offer.op.to_i
    assert_equal 2, @from_json.op.to_i
  end

  def test_pack
    packed = Lib::BOOTP::Packet.new(op:2 , yiaddr:'10.0.0.1', chaddr: '00:11:22:33:44:55', xid: @offer.xid).pack
    packed += [0x63825363.to_i].pack('N')
    packed += [53,1,2].pack('C3')
    packed += [51,4,3600].pack('C2N')
    packed += [54,4,167772162].pack('C2N')
    packed += [255].pack('C')
    (1..48).each do
      packed += [0].pack('C')
    end
    assert_equal packed, @offer.pack
    assert_equal packed, @from_json.pack
  end

  def test_sanity_check_yiaddr
    offer = @offer.dup
    offer.yiaddr= 0
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end

    offer = @from_json.dup
    offer.yiaddr = 0
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

  def test_sanity_check_option51
    offer = @offer.dup
    offer.options.del(51)
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end

    offer = @from_json.dup
    offer.options.del(51)
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

  def test_sanity_check_option54
    offer = @offer.dup
    offer.options.del(54)
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end

    offer = @from_json.dup
    offer.options.del(54)
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

  def test_sanity_check_option50
    offer = @offer.dup
    offer.option50 = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end

    offer = @from_json.dup
    offer.option50 = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

  def test_sanity_check_option55
    offer = @offer.dup
    offer.option55 = [1,2,3]
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end

    offer = @from_json.dup
    offer.option55 = [1, 2, 3]
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

  def test_snity_check_option57
    offer = @offer.dup
    offer.option57 = 800
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end

    offer = @from_json.dup
    offer.option57 = 800
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

end