#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 23.03.2016 by Piotr Wojcieszonek



require_relative 'option'
require_relative 'type/raw'

module Lib
  module DHCP
    class Option91 < Option
      # This option allows the receiver to determine the time of the
      # most recent access of the client.  It is particularly useful
      # when DHCPLEASEACTIVE messages from two different DHCP servers
      # need to be compared, although it can be useful in other
      # situations.  The value is a duration in seconds from the
      # current time into the past when this IP address was most
      # recently the subject of communication between the client and
      #     the DHCP server.
      # The code for the this option is 91.  The length of the this option is 4 octets.

      def_delegators :@payload, :to_s

      def initialize(time)
        super CLIENT_LAST_TRANSACTION_TIME, time.to_i
      end

      def payload=(time)
        @payload = time.to_i
      end

      def pack
        [@oid, 4, @payload].pack('C2N')
      end

      def len
        4
      end

      alias_method :time, :payload
      alias_method :time=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{NAME[oid]} - #{oid}" unless oid.to_i == CLIENT_LAST_TRANSACTION_TIME
        raise ArgumentError, "Wrong #{NAME[oid]} length - #{len}" unless len == 4
        self.new payload.unpack('N').first.to_i
      end
    end
  end
end