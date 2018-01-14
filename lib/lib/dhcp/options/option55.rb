#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option55 < Option
      # Parameter Request List The code for this option is 55.  Its minimum length is 1.

      def_delegators :@payload, :map, :map!, :[], :[]=, :each, :<<, :shift, :pop

      def initialize(*request_option)
        super PARAMETER_REQUEST, request_option
      end

      def pack
        [@oid, @payload.size, *@payload].pack('C*')
      end

      def to_s
        @payload.join(', ')
      end

      def len
        @payload.size
      end

      def payload=(*request_option)
        @payload = request_option
      end

      # def <<(request_option)
      #   @payload << request_option
      # end

      alias_method :request_option, :payload
      alias_method :request_option=, :payload=
      alias_method :add, :<<

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for #{NAME[oid]} - #{oid}" unless oid.to_i == PARAMETER_REQUEST
        raise ArgumentError, "Wrong #{NAME[oid]} length - #{len}" unless len > 1
        self.new *payload.unpack('C*')
      end
    end
  end
end