#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option46 < Option
      # NetBIOS over TCP/IP Node Type Option, The code for this option is 46.  The length of this option is always 1

      def_delegators :@payload, :to_s

      def initialize(netbios_node_type)
        super NETBIOS_TCP_IP, netbios_node_type.to_i
      end

      def payload=(netbios_node_type)
        @payload = netbios_node_type.to_i
      end

      def pack
        [@oid, 1, @payload].pack('C3')
      end

      def len
        1
      end

      alias_method :netbios_node_type, :payload
      alias_method :netbios_node_type=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{NAME[oid]} - #{oid}" unless oid.to_i == NETBIOS_TCP_IP
        raise ArgumentError, "Wrong #{NAME[oid]} length - #{len}" unless len == 1
        self.new payload.unpack('C').first.to_i
      end
    end
  end
end