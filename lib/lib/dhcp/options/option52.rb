#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option52 < Option
      # Option Overload The code for this option is 52, and its length is 1.  Legal values 1,2,3

      def_delegators :@payload, :to_s

      def initialize(overload)
        raise ArgumentError, "Illegal value for OPTION OVERLOAD = #{overload}" unless (1..3).include? overload.to_i
        super OPTION_OVERLOAD, overload.to_i
      end

      def payload=(overload)
        raise ArgumentError, "Illegal value for OPTION OVERLOAD = #{overload}" unless (1..3).include? overload.to_i
        @payload = overload.to_i
      end

      def pack
        [@oid, 1, @payload].pack('C3')
      end

      def len
        1
      end

      alias_method :overload, :payload
      alias_method :overload=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{NAME[oid]} - #{oid}" unless oid.to_i == OPTION_OVERLOAD
        raise ArgumentError, "Wrong #{NAME[oid]} length - #{len}" unless len == 1
        self.new payload.unpack('C').first.to_i
      end
    end
  end
end