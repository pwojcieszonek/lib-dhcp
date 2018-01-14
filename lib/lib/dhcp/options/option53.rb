#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option53 < Option
      # DHCP MESSAGE TYPE - This option is used to convey the type of the DHCP message.
      # The code for this option is 53, and its length is 1.

      def_delegators :@payload, :to_s

      def initialize(message_type)
        raise ArgumentError, "Illegal value for DHCP Message Type = #{message_type}" unless (1..255).include? message_type.to_i
        super MESSAGE_TYPE, message_type.to_i
      end

      def payload=(message_type)
        raise ArgumentError, "Illegal value for DHCP Message Type  = #{message_type}" unless (1..255).include? message_type.to_i
        @payload = message_type.to_i
      end

      def pack
        [@oid, 1, @payload].pack('C3')
      end

      def len
        1
      end

      def to_s
        Lib::DHCP::Message::NAME[@payload.to_i].to_s.upcase
      end

      alias_method :message_type, :payload
      alias_method :message_type=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{NAME[oid]} - #{oid}" unless oid.to_i == MESSAGE_TYPE
        raise ArgumentError, "Wrong #{NAME[oid]} length - #{len}" unless len == 1
        self.new payload.unpack('C').first.to_i
      end
    end
  end
end