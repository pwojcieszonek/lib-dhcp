#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 25.03.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'

class Request < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    options = []
    options << Lib::DHCP::Option50.new('10.0.0.1')
    @request = Lib::DHCP::Message::Request.new(chaddr: '00:11:22:33:44:55', options: options, xid: 2486822374)
    @from_json = Lib::DHCP::Message::Request.from_json @request.to_json
  end

  def test_to_json
    json = { "op" => { "code" => "1", "name" => "BOOTREQUEST" },
             "htype" => { "code" => "1", "name" => "Ethernet (10Mb)" },
             "hlen" => "6",
             "hops" => "0",
             "xid" => "2486822374",
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
             "options" =>
               [{ "name" => "Requested IP Address",
                  "oid" => 50,
                  "len" => 4,
                  "value" =>
                    { "address" => "10.0.0.1",
                      "mask" => "255.255.255.255",
                      "net" => "10.0.0.1",
                      "broadcast" => "10.0.0.1",
                      "cidr" => "10.0.0.1/32" } },
                { "name" => "DHCP Message Type", "oid" => 53, "len" => 1, "value" => 3 }] }
    assert_equal json, JSON.parse(@request.to_json)
  end

  def test_message_type
    assert_equal 3, @request.option53.to_i
    assert_equal 3, @from_json.option53.to_i
  end

  def test_op_code
    assert_equal 1, @request.op.to_i
    assert_equal 1, @from_json.op.to_i
  end

  def test_sanity_check
    assert_nil  @request.send(:sanity_check)
    assert_nil @from_json.send(:sanity_check)
  end

  def test_sanity_check_yiaddr
    request = @request.dup
    request.yiaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Request do
      request.send(:sanity_check)
    end

    request = @from_json.dup
    request.yiaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Request do
      request.send(:sanity_check)
    end
  end

  def test_sanity_check_ciaddr
    request = @request.dup
    request.ciaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Request do
      request.send(:sanity_check)
    end
    request.options.del 50
    assert_nil  request.send(:sanity_check)

    request = @from_json.dup
    request.ciaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Request do
      request.send(:sanity_check)
    end
    request.options.del 50
    assert_nil request.send(:sanity_check)
  end

  def test_pack
    packed = Lib::BOOTP::Packet.new(op:1 , chaddr: '00:11:22:33:44:55', xid: @request.xid).pack
    packed += [0x63825363.to_i].pack('N')
    packed += [53,1,3].pack('C3')
    packed += [50,4,167772161].pack('C2N')
    packed += [255].pack('C')
    (1..54).each do
      packed += [0].pack('C')
    end
    assert_equal packed, @request.pack
    assert_equal packed, @from_json.pack
  end


end