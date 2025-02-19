#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 25.03.2016 by Piotr Wojcieszonek

require_relative '../../test_helper'

class Message < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @message = Lib::DHCP::Message.new(op: 1, chaddr: '00:11:22:33:44:55', xid: 3474444682)
    @message.option53 = 1
    @from_json = Lib::DHCP::Message.from_json @message.to_json
  end

  def test_to_json
    json = { "op" => { "code" => "1", "name" => "BOOTREQUEST" },
             "htype" => { "code" => "1", "name" => "Ethernet (10Mb)" },
             "hlen" => "6",
             "hops" => "0",
             "xid" => "3474444682",
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
             "options" => [{"name"=>"DHCP Message Type", "oid"=>53, "len"=>1, "value"=>1}] }
    assert_equal json, JSON.parse(@message.to_json)
  end

  def test_respond_to_name
    assert_respond_to @message, :name
    assert_respond_to @from_json, :name
  end

  def test_name
    assert_equal 'DHCP Discover', @message.name
    assert_equal 'DHCP Discover', @from_json.name
  end

  def test_pack
    packed = Lib::BOOTP::Packet.new(op:1 , chaddr: '00:11:22:33:44:55', xid: @message.xid).pack
    packed += [0x63825363.to_i].pack('N')
    packed += [53,1,1].pack('C3')
    packed += [255].pack('C')
    (1..60).each do
      packed += [0].pack('C')
    end
    assert_equal packed, @message.pack

    packed = Lib::BOOTP::Packet.new(op: 1, chaddr: '00:11:22:33:44:55', xid: @message.xid).pack
    packed += [0x63825363.to_i].pack('N')
    packed += [53, 1, 1].pack('C3')
    packed += [255].pack('C')
    (1..60).each do
      packed += [0].pack('C')
    end

    assert_equal packed, @from_json.pack
  end

  def test_unpack_discover
    packet = Lib::DHCP::Packet.new(op:1, chaddr: '00:11:22:33:44:55')
    packet.option53 = 1
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::Discover, message
  end

  def test_unpack_offer
    packet = Lib::DHCP::Packet.new(op:2, chaddr: '00:11:22:33:44:55')
    packet.option53 = 2
    assert_raises Lib::DHCP::SanityCheck::Offer do
      Lib::DHCP::Message.unpack packet.pack
    end
    packet.yiaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Offer do
      Lib::DHCP::Message.unpack packet.pack
    end
    packet.option51 = 3600
    assert_raises Lib::DHCP::SanityCheck::Offer do
      Lib::DHCP::Message.unpack packet.pack
    end
    packet.option54 = '10.0.0.2'
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::Offer, message
  end

  def test_unpack_request
    packet = Lib::DHCP::Packet.new(op:1, chaddr: '00:11:22:33:44:55')
    packet.option53 = 3
    assert_raises Lib::DHCP::SanityCheck::Request do
      Lib::DHCP::Message.unpack packet.pack
    end
    packet.option50 = '10.0.0.1'
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::Request, message
  end

  def test_unpack_decline
    packet = Lib::DHCP::Packet.new(op:1, chaddr: '00:11:22:33:44:55')
    packet.option53 = 4
    assert_raises Lib::DHCP::SanityCheck::Decline do
      Lib::DHCP::Message.unpack packet.pack
    end
    packet.option50 = '10.0.0.1'
    packet.option54 = '10.0.0.2'
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::Decline, message
  end

  def test_unpcack_ack
    packet = Lib::DHCP::Packet.new(op:2, chaddr: '00:11:22:33:44:55')
    packet.option53 = 5
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::ACK, message
  end

  def test_unpack_nack
    packet = Lib::DHCP::Packet.new(op:2, chaddr: '00:11:22:33:44:55')
    packet.option53 = 6
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::NACK, message
  end

  def test_unpack_release
    packet = Lib::DHCP::Packet.new(op:1, chaddr: '00:11:22:33:44:55')
    packet.option53 = 7
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::Release, message
  end

  def test_unpack_inform
    packet = Lib::DHCP::Packet.new(op:1, chaddr: '00:11:22:33:44:55')
    packet.option53 = 8
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::Inform, message
  end

  def test_unpack_lease_query
    packet = Lib::DHCP::Packet.new(op:1, chaddr: '00:11:22:33:44:55')
    packet.option53 = 10
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::LeaseQuery, message
  end

  def test_unpack_lease_unassigned
    packet = Lib::DHCP::Packet.new(op:2, chaddr: '00:11:22:33:44:55')
    packet.option53 = 11
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::LeaseUnassigned, message
  end

  def test_unpack_lease_unknown
    packet = Lib::DHCP::Packet.new(op:2, chaddr: '00:11:22:33:44:55')
    packet.option53 = 12
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::LeaseUnknown, message
  end

  def test_lease_active
    packet = Lib::DHCP::Packet.new(op:2, chaddr: '00:11:22:33:44:55')
    packet.option53 = 13
    message = Lib::DHCP::Message.unpack packet.pack
    assert_kind_of Lib::DHCP::Message::LeaseActive, message
  end

end