#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option35 < Option
      # ARP Cache Timeout Option, The code for this option is 35, and its length is 4.

      def_delegators :@payload, :to_s

      def initialize(arp_timeout)
        super ARP_TIMEOUT, arp_timeout.to_i
      end

      def payload=(arp_timeout)
        @payload = arp_timeout.to_i
      end

      def pack
        [@oid, 4, @payload].pack('C2N')
      end

      def len
        4
      end

      alias_method :arp_timeout, :payload
      alias_method :arp_timeout=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{Net::DHCP::Option::NAME[oid]} - #{oid}" unless oid.to_i == ARP_TIMEOUT
        raise ArgumentError, "Wrong #{Net::DHCP::Option::NAME[oid]} length - #{len}" unless len == 4
        self.new payload.unpack('N').first.to_i
      end
    end
  end
end