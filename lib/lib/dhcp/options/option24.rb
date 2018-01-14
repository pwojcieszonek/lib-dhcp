#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'


module Lib
  module DHCP
    class Option24 < Option
      # Path MTU Aging Timeout Option, The code for this option is 24, and its length is 4.

      def_delegators :@payload, :to_s

      def initialize(mtu_aging)
        super MTU_TIMEOUT, mtu_aging.to_i
      end

      # def payload=(mtu_aging)
      #   @payload = mtu_aging
      # end

      def pack
        [MTU_TIMEOUT, 4, @payload.to_i].pack('C2N')
      end

      def len
        4
      end

      alias_method :mtu_time_out, :payload
      alias_method :mtu_time_out=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for MTU_TIMEOUT Option - #{oid}" unless oid.to_i == MTU_TIMEOUT
        raise ArgumentError, "Wrong MTU_TIMEOUT Option length - #{len}" unless len == 4
        self.new payload.unpack('N').first.to_i
      end

    end
  end
end