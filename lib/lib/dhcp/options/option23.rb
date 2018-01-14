#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek



require_relative 'option'

module Lib
  module DHCP
    class Option23 < Option
      # Default IP Time-to-live, The code for this option is 23, and its length is 1.

      def_delegators :@payload, :to_s

      def initialize(ttl)
        super IP_TTL, ttl.to_i
      end

      def payload=(ttl)
        @payload = ttl.to_i
      end

      def pack
        [IP_TTL, 1, @payload.to_i].pack('C3')
      end

      def len
        1
      end

      alias_method :ttl, :payload
      alias_method :ttl=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for TCPTTL Option - #{oid}" unless oid.to_i == IP_TTL
        raise ArgumentError, "Wrong TCPTTL Option length - #{len}" unless len == 1
        self.new payload.unpack('C').first.to_i
      end
    end
  end
end