#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.03.2016 by Piotr Wojcieszonek


require 'lib/dhcp/options/option'

module Lib
  module DHCP
    class Option0 < Option
      def initialize
        super PAD
      end

      def pack
        [PAD].pack('C')
      end

      def len
        0
      end

      private

      def self.unpack(oid, len, payload=nil)
        payload = nil if payload.size == 0
        raise ArgumentError, "OID Mismatch for PAD Option - #{oid}" unless oid.to_i == PAD
        raise ArgumentError, "Wrong PAD Option length - #{len}" unless len == 0
        raise ArgumentError, "PAD Option shouldn't have payload - #{payload} - given" unless payload.nil?
        self.new
      end
    end
  end
end