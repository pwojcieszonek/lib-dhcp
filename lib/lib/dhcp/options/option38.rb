#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option38 < Option
      # TCP Keepalive Interval Option, The code for this option is 38, and its length is 4.

      def_delegators :@payload, :to_s

      def initialize(tcp_keepalive)
        super TCP_KEEP_ALIVE, tcp_keepalive.to_i
      end

      def payload=(tcp_keepalive)
        @payload = tcp_keepalive.to_i
      end

      def pack
        [@oid, 4, @payload].pack('C2N')
      end

      def len
        4
      end

      alias_method :tcp_keepalive, :payload
      alias_method :tcp_keepalive=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{NAME[oid]} - #{oid}" unless oid.to_i == TCP_KEEP_ALIVE
        raise ArgumentError, "Wrong #{NAME[oid]} length - #{len}" unless len == 4
        self.new payload.unpack('N').first.to_i
      end
    end
  end
end