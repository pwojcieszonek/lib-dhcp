#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option22 < Option
      # Maximum Datagram Reassembly Size The code for this option is 22, and its length is 2.

      def_delegators :@payload, :to_s

      def initialize(max_reassembly_size)
        super MAX_REASSEMBLE_SIZE, max_reassembly_size.to_i
      end

      def pack
        [MAX_REASSEMBLE_SIZE, 2, @payload.to_i].pack('C2n')
      end

      def payload=(max_reassembly_size)
        @payload = max_reassembly_size.to_i
      end

      def len
        2
      end

      alias_method :max_reassembly_size, :payload
      alias_method :max_reassembly_size=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for MAXREASSEMBLESIZE Option - #{oid}" unless oid.to_i == MAX_REASSEMBLE_SIZE
        raise ArgumentError, "Wrong MAXREASSEMBLESIZE Option length - #{len}" unless len == 2
        self.new payload.unpack('n').first.to_i
      end
    end
  end
end