#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 24.03.2016 by Piotr Wojcieszonek


require 'lib/dhcp'

module Lib
  module DHCP
    class Message < Packet

      BOOTREQUEST       = 1
      BOOTREPLY         = 2

      DISCOVER          = 1
      OFFER             = 2
      REQUEST           = 3
      DECLINE           = 4
      ACKNOWLEDGE       = 5
      NOT_ACKNOWLEDGE   = 6
      RELEASE           = 7
      INFORM            = 8
      LEASE_QUERY       = 10
      LEASE_UNASSIGNED  = 11
      LEASE_UNKNOWN     = 12
      LEASE_ACTIVE      = 13

      NAME = {
          1   => 'DHCP Discover',
          2   => 'DHCP Offer',
          3   => 'DHCP Request',
          4   => 'DHCP Decline',
          5   => 'DHCP ACK',
          6   => 'DHCP NAK',
          7   => 'DHCP Release',
          8   => 'DHCP Inform',
          9   => '',
          10  => 'DHCP LeaseQuery',
          11  => 'DHCP LeaseUnassigned',
          12  => 'DHCP LeaseUnknown',
          13  => 'DHCP LeaseActive'
      }

      def name
        if option53.nil?
          nil
        else
          NAME[option53.to_i]
        end
      end

      def self.from_json(json)
        self.unpack(super(json).pack)
      end

      def self.unpack(packet)
        packet =  super(packet)
        # noinspection RubyResolve
        res = case packet.option53.value.to_i
                when DISCOVER
                  Lib::DHCP::Message::Discover.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  => packet.options
                  )
                when OFFER
                  Lib::DHCP::Message::Offer.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  => packet.options
                  )
                when REQUEST
                  Lib::DHCP::Message::Request.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  => packet.options
                  )

                when DECLINE
                  Lib::DHCP::Message::Decline.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  => packet.options
                  )
                when ACKNOWLEDGE
                  Lib::DHCP::Message::ACK.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  => packet.options
                  )
                when NOT_ACKNOWLEDGE
                  Lib::DHCP::Message::NACK.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  => packet.options
                  )
                when RELEASE
                  Lib::DHCP::Message::Release.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  => packet.options
                  )
                when INFORM
                  Lib::DHCP::Message::Inform.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  =>  packet.options
                  )
                when LEASE_QUERY
                  Lib::DHCP::Message::LeaseQuery.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  => packet.options
                  )
                when LEASE_UNASSIGNED
                  Lib::DHCP::Message::LeaseUnassigned.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  => packet.options
                  )
                when LEASE_UNKNOWN
                  Lib::DHCP::Message::LeaseUnknown.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  => packet.options
                  )
                when LEASE_ACTIVE
                  Lib::DHCP::Message::LeaseActive.new(
                      :htype    => packet.htype,
                      :hlen     => packet.hlen,
                      :hops     => packet.hops,
                      :xid      => packet.xid,
                      :secs     => packet.secs,
                      :flags    => packet.flags,
                      :ciaddr   => packet.ciaddr,
                      :yiaddr   => packet.yiaddr,
                      :siaddr   => packet.siaddr,
                      :giaddr   => packet.giaddr,
                      :chaddr   => packet.chaddr,
                      :sname    => packet.sname,
                      :file     => packet.file,
                      :options  => packet.options
                  )
                else
                  raise ArgumentError, "Unknown DHCP MESSAGE TYPE #{packet.option53.to_i}"
              end
        res.send(:sanity_check)
        res
      end

      def pack
        sanity_check
        super
      end

      protected

      def sanity_check
        raise Lib::DHCP::SanityCheck, "Can't pack DHCP Message without Option 53 - Message Type set" if self.option53.nil?
      end
    end
  end
end