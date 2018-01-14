#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 23.03.2016 by Piotr Wojcieszonek


module Lib
  module DHCP
    class Option255 < Option
      def initialize
        super END_OPTION
      end

      def pack
        [END_OPTION].pack('C')
      end

      private

      def self.unpack(oid, len, payload=nil)
        payload = nil if payload.size == 0
        len = 0 if len.nil?
        raise ArgumentError, "OID Mismatch for END Option - #{oid}" unless oid.to_i == END_OPTION
        raise ArgumentError, "Wrong END Option length - #{len}" unless len == 0
        raise ArgumentError, "END Option shouldn't have payload - #{payload} - given" unless payload.nil?
        self.new
      end
    end
  end
end