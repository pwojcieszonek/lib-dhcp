#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option58 < Option
      # Renewal (T1) Time Value The code for this option is 58, and its length is 4.

      def_delegators :@payload, :to_s

      def initialize(renewal_time)
        super RENEW_TIME, renewal_time.to_i
      end

      def pack
        [@oid, 4, @payload.to_i].pack('C2N')
      end

      def len
        4
      end

      def payload=(renewal_time)
        @payload = renewal_time.to_i
      end

      alias_method :renewal_time, :payload
      alias_method :renewal_time=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{NAME[oid]} - #{oid}" unless oid.to_i == RENEW_TIME
        raise ArgumentError, "Wrong #{NAME[oid]} length - #{len}" unless len.to_i == 4

        self.new payload.unpack('N').first.to_i

      end
    end
  end
end