#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 23.03.2016 by Piotr Wojcieszonek

require_relative '../test_helper'

class Packet < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
  end

  def test_respond_to_option
    (0..255).each do |i|
      assert_respond_to @packet, "option#{i}".to_sym
    end
  end

  def test_respond_to_s
    assert_respond_to @packet, :to_s
  end

  def test_respond_to_options
    assert_respond_to @packet, :options
  end

  def test_respond_to_pack
    assert_respond_to @packet, :pack
  end

  def test_respond_to_unpack
    assert_respond_to Lib::DHCP::Packet, :unpack
  end

  def test_respond_to_op
    assert_respond_to @packet, :op
  end

  def test_respond_to_op=
    assert_respond_to @packet, :op=
  end

  def test_op
    assert_kind_of Lib::BOOTP::Packet::OpCode, @packet.op
  end

  def test_op=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.op= 2
    assert_kind_of Lib::BOOTP::Packet::OpCode, packet.op
  end

  def test_respond_to_htype
    assert_respond_to @packet, :htype
  end

  def test_respond_to_htype=
    assert_respond_to @packet, :htype=
  end

  def test_htype
    assert_kind_of Lib::BOOTP::Packet::HardwareAddressType, @packet.htype
  end

  def test_htype=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.htype= 2
    assert_kind_of Lib::BOOTP::Packet::HardwareAddressType, packet.htype
  end

  def test_respond_to_hlen
    assert_respond_to @packet, :hlen
  end

  def test_respond_to_hlen=
    assert_respond_to @packet, :hlen=
  end

  def test_hlen
    assert_kind_of Lib::BOOTP::Packet::HardwareAddressLength, @packet.hlen
  end

  def test_hlen=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.hlen= 2
    assert_kind_of Lib::BOOTP::Packet::HardwareAddressLength, packet.hlen
  end

  def test_respond_to_hops
    assert_respond_to @packet, :hops
  end

  def test_respond_to_hops=
    assert_respond_to @packet, :hops=
  end

  def test_hops
    assert_kind_of Lib::BOOTP::Packet::HopCount, @packet.hops
  end

  def test_hops=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.hops= 2
    assert_kind_of Lib::BOOTP::Packet::HopCount, packet.hops
  end

  def test_respond_to_xid
    assert_respond_to @packet, :xid
  end

  def test_respond_to_xid=
    assert_respond_to @packet, :xid=
  end

  def test_xid
    assert_kind_of Lib::BOOTP::Packet::TransactionID, @packet.xid
  end

  def test_xid=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.hops= 0xFF
    assert_kind_of Lib::BOOTP::Packet::TransactionID, packet.xid
  end

  def test_respond_to_secs
    assert_respond_to @packet, :secs
  end

  def test_respond_to_secs=
    assert_respond_to @packet, :secs=
  end

  def test_secs
    assert_kind_of Lib::BOOTP::Packet::Seconds, @packet.secs
  end

  def test_secs=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.secs= 0xFF
    assert_kind_of Lib::BOOTP::Packet::Seconds, packet.secs
  end

  def test_respond_to_flags
    assert_respond_to @packet, :flags
  end

  def test_respond_to_flags=
    assert_respond_to @packet, :flags=
  end

  def test_flags
    assert_kind_of Lib::BOOTP::Packet::Flags, @packet.flags
  end

  def test_flags=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.flags= :broadcast
    assert_kind_of Lib::BOOTP::Packet::Flags, packet.flags
  end

  def test_respond_to_ciaddr
    assert_respond_to @packet, :ciaddr
  end

  def test_respond_to_ciaddr=
    assert_respond_to @packet, :ciaddr=
  end

  def test_ciaddr
    assert_kind_of Lib::BOOTP::Packet::IPAddress, @packet.ciaddr
  end

  def test_ciaddr=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.ciaddr = '10.0.0.1'
    assert_kind_of Lib::BOOTP::Packet::IPAddress, packet.ciaddr
  end

  def test_respond_to_yiaddr
    assert_respond_to @packet, :yiaddr
  end

  def test_respond_to_yiaddr=
    assert_respond_to @packet, :yiaddr=
  end

  def test_yiaddr
    assert_kind_of Lib::BOOTP::Packet::IPAddress, @packet.yiaddr
  end

  def test_yiaddr=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.yiaddr = '10.0.0.1'
    assert_kind_of Lib::BOOTP::Packet::IPAddress, packet.yiaddr
  end

  def test_respond_to_siaddr
    assert_respond_to @packet, :siaddr
  end

  def test_respond_to_siaddr=
    assert_respond_to @packet, :siaddr=
  end

  def test_siaddr
    assert_kind_of Lib::BOOTP::Packet::IPAddress, @packet.siaddr
  end

  def test_siaddr=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.siaddr = '10.0.0.1'
    assert_kind_of Lib::BOOTP::Packet::IPAddress, packet.siaddr
  end

  def test_respond_to_giaddr
    assert_respond_to @packet, :giaddr
  end

  def test_respond_to_giaddr=
    assert_respond_to @packet, :giaddr=
  end

  def test_giaddr
    assert_kind_of Lib::BOOTP::Packet::IPAddress, @packet.giaddr
  end

  def test_giaddr=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.giaddr = '10.0.0.1'
    assert_kind_of Lib::BOOTP::Packet::IPAddress, packet.giaddr
  end

  def test_respond_to_chaddr
    assert_respond_to @packet, :chaddr
  end

  def test_respond_to_chaddr=
    assert_respond_to @packet, :chaddr=
  end

  def test_chaddr
    assert_instance_of Lib::BOOTP::Packet::ClientHardwareAddress, @packet.chaddr
  end

  def test_chaddr=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.chaddr = '11:22:33:44:55:66'
    assert_instance_of Lib::BOOTP::Packet::ClientHardwareAddress, packet.chaddr
  end

  def test_respond_to_sname
    assert_respond_to @packet, :sname
  end

  def test_respond_to_sname=
    assert_respond_to @packet, :sname=
  end

  def test_sname
    assert_instance_of Lib::BOOTP::Packet::ServerHostName, @packet.sname
  end

  def test_sname=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.sname = 'server_host_name'
    assert_instance_of Lib::BOOTP::Packet::ServerHostName, packet.sname
  end

  def test_respond_to_file
    assert_respond_to @packet, :file
  end

  def test_respond_to_file=
    assert_respond_to @packet, :file=
  end

  def test_file
    assert_instance_of Lib::BOOTP::Packet::BootFile, @packet.file
  end

  def test_file=
    packet = Lib::DHCP::Packet.new(chaddr: '00:11:22:33:44:55')
    packet.file = 'file'
    assert_instance_of Lib::BOOTP::Packet::BootFile, packet.file
  end

  def test_options
    assert_instance_of  Lib::DHCP::Options, @packet.options
  end

end