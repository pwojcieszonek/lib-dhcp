#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option26 < Option

      # Interface MTU Option, The code for this option is 26, and its length is 2.

      def_delegators :@payload, :to_s

      def initialize(mtu)
        super MTU_SIZE, mtu.to_i
      end

      def pack
        [@oid, 2, @payload.to_i].pack('C2n')
      end

      def payload=(mtu)
        @payload = mtu.to_i
      end

      def len
        2
      end

      alias_method :mtu, :payload
      alias_method :mtu=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{Net::DHCP::Option::NAME[oid]} - #{oid}" unless oid.to_i == MTU_SIZE
        raise ArgumentError, "Wrong #{Net::DHCP::Option::NAME[oid]} length - #{len}" unless len == 2
        self.new payload.unpack('n').first.to_i
      end

    end
  end
end