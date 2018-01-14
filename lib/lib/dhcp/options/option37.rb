#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option37 < Option
      # TCP Default TTL Option, The code for this option is 37, and its length is 1.

      def_delegators :@payload, :to_s

      def initialize(tcp_ttl)
        super TCP_TTL, tcp_ttl.to_i
      end

      def payload=(tcp_ttl)
        @payload = tcp_ttl.to_i
      end

      def pack
        [@oid, 1, @payload].pack('C3')
      end

      def len
        1
      end

      alias_method :tcp_ttl, :payload
      alias_method :tcp_ttl=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{NAME[oid]} - #{oid}" unless oid.to_i == TCP_TTL
        raise ArgumentError, "Wrong #{NAME[oid]} length - #{len}" unless len == 1
        self.new payload.unpack('C').first.to_i
      end
    end
  end
end