#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option57 < Option
      # Maximum DHCP Message Size. The code for this option is 57, and its length is 2.
      # The minimum legal value is 576 octets.

      def_delegators :@payload, :to_s

      def initialize(message_size)
        # raise ArgumentError, "Minimal message size is 576. #{message_size} given" unless message_size.to_i >= 576
        super MAX_MESSAGE_SIZE, message_size.to_i
      end

      def pack
        [@oid, 2, @payload.to_i].pack('C2n')
      end

      def len
        2
      end

      def payload=(message_size)
        # raise ArgumentError, "Minimal message size is 576. #{message_size} given" unless message_size.to_i >= 576
        @payload = message_size.to_i
      end

      alias_method :max_message_size, :payload
      alias_method :max_message_size=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{NAME[oid]} - #{oid}" unless oid.to_i == MAX_MESSAGE_SIZE
        raise ArgumentError, "Wrong #{NAME[oid]} length - #{len}" unless len == 2

        message_size = payload.unpack('n').first.to_i

        #raise ArgumentError, "Minimal message size is 576. #{message_size} given" unless message_size.to_i >= 576

        self.new message_size

      end
    end
  end
end