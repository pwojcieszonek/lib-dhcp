#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class Option13 < Option
      # Boot File Size Option The code for this option is 13, and its length is 2

      def_delegators :@payload, :to_s

      def initialize(file_size)
        super BOOT_FILE_SIZE, file_size.to_i
      end

      def payload=(file_size)
        @payload = file_size.to_i
      end

      def len
        2
      end

      def pack
        [BOOT_FILE_SIZE, 2, @payload.to_i].pack('C2n')
      end

      alias_method :file_size, :payload
      alias_method :file_size=, :payload=

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for BOOT FILE SIZE Option - #{oid}" unless oid.to_i == BOOT_FILE_SIZE
        raise ArgumentError, "Wrong BOOT FILE SIZE Option length - #{len}" unless len == 2
        self.new payload.unpack('n').first
      end
    end
  end
end