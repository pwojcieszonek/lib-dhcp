#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.03.2016 by Piotr Wojcieszonek

require 'lib/dhcp/options/option'

module Lib
  module DHCP
    class Option2 < Option
      # Time Offset length is 4 octets

      def_delegators :@payload, :to_s

      def initialize(time_offset)
        super TIME_OFFSET, time_offset.to_i
      end

      def time_offset=(time_offset)
        raise ArgumentError, "TIME OFFSET out of range - #{time_offset}" if time_offset.to_i > 0xffffffff
        @payload = time_offset.to_i
      end

      def pack
        [TIME_OFFSET, 4, @payload].pack('C2N')
      end

      def len
        4
      end

      alias_method :time_offset, :payload
      alias_method :payload=, :time_offset=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for TIME OFFSET Option - #{oid}" unless oid.to_i == TIME_OFFSET
        raise ArgumentError, "Wrong TIME OFFSET Option length - #{len}" unless len == 4
        time_offset = payload.to_s.unpack('N').first
        raise ArgumentError, "TIME OFFSET out of range - #{time_offset}" if time_offset.to_i > 0xffffffff
        self.new time_offset
      end
    end
  end
end