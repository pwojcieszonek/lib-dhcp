#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option59 < Option
      # Rebinding (T2) Time Value The code for this option is 59, and its length is 4.

      def_delegators :@payload, :to_s

      def initialize(rebinding_time)
        super REBIND_TIME, rebinding_time.to_i
      end

      def pack
        [@oid, 4, @payload.to_i].pack('C2N')
      end

      def len
        4
      end

      def payload=(rebinding_time)
        @payload = rebinding_time.to_i
      end

      alias_method :rebinding_time, :payload
      alias_method :rebinding_time=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{NAME[oid]} - #{oid}" unless oid.to_i == REBIND_TIME
        raise ArgumentError, "Wrong #{NAME[oid]} length - #{len}" unless len == 4

        self.new payload.unpack('N').first.to_i

      end
    end
  end
end