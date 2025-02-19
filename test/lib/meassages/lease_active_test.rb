#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 25.03.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'

class LeaseActive < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @lease_active = Lib::DHCP::Message::LeaseActive.new(chaddr: '00:11:22:33:44:55', xid: 2971459332)
    @from_json = Lib::DHCP::Message.from_json @lease_active.to_json
  end

  def test_to_json
    json = { "op" => { "code" => "2", "name" => "BOOTREPLY" },
             "htype" => { "code" => "1", "name" => "Ethernet (10Mb)" },
             "hlen" => "6",
             "hops" => "0",
             "xid" => "2971459332",
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
             "options" => [{ "name" => "DHCP Message Type", "oid" => 53, "len" => 1, "value" => 13 }] }
    assert_equal json, JSON.parse(@lease_active.to_json)
  end

  def test_op_code
    assert_equal 2, @lease_active.op.to_i
    assert_equal 2, @from_json.op.to_i
  end

  def test_message_type
    assert_equal 13, @lease_active.option53.to_i
    assert_equal 13, @from_json.option53.to_i
  end

  def test_pack
    packed = Lib::BOOTP::Packet.new(op:2 , chaddr: '00:11:22:33:44:55', xid: @lease_active.xid).pack
    packed += [0x63825363.to_i].pack('N')
    packed += [53,1,13].pack('C3')
    packed += [255].pack('C')
    (1..60).each do
      packed += [0].pack('C')
    end
    assert_equal packed, @lease_active.pack
    assert_equal packed, @from_json.pack
  end

  def test_from_json
    assert_instance_of Lib::DHCP::Message::LeaseActive, @from_json
  end

end