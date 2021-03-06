#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option51 < Option
      # IP Address Lease Time The code for this option is 51, and its length is 4.

      def_delegators :@payload, :to_s

      def initialize(leasetime)
        super LEASE_TIME, leasetime.to_i
      end

      def payload=(leasetime)
        @payload = leasetime.to_i
      end

      def pack
        [@oid, 4, @payload].pack('C2N')
      end

      def len
        4
      end

      alias_method :leasetime, :payload
      alias_method :leasetime=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{NAME[oid]} - #{oid}" unless oid.to_i == LEASE_TIME
        raise ArgumentError, "Wrong #{NAME[oid]} length - #{len}" unless len == 4
        self.new payload.unpack('N').first.to_i
      end
    end
  end
end