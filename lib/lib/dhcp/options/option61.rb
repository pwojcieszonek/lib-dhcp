#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option61 < Option
      # Client-identifier The code for this option is 61, and its minimum length is 2.

      def_delegators :@payload, :to_s

      def initialize(client_id)
        id =  client_id.to_s.gsub(/(:|-|\.|,)/,'').to_s#.pack('H*').unpack('C*')
        super 61, id
      end

      def len
        @payload.size / 2
      end

      def pack
        op61 = [@payload.to_s.gsub(/(:|-|\.|,)/,'').to_s].pack('H*').unpack('C*')
        [61, len, op61.map{|item| item.to_s(16).rjust(2,'0')}.join('')].pack('C2H*')
      end

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "Wrong CLIENT-IDENTIFIER Option length - #{len}" unless len > 0
        self.new payload.unpack('H*').first.to_s
      end
    end
  end
end