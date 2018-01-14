#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require 'net/address'

module Lib
  module DHCP
    class Option21 < Option

      # Policy Filter Option The code for this option is 21.
      # The minimum length of this option is 8, and the length MUST be a multiple of 8.
      # The filters consist of a list of IP addresses and masks

      def_delegators :@payload, :to_s

      def initialize(*address)

        address.map! do |ip|
          if ip.is_a? Net::Address::IPv4
            ip
          elsif ip.is_a?Array
            Net::Address::IPv4.new(*ip)
          else
            Net::Address::IPv4.new(ip)
          end
        end

        super POLICY_FILTER, address

      end

      def pack
        [POLICY_FILTER, @payload.size * 8, *@payload.map{|ip| [ip.to_i, ip.mask.to_i]}.flatten].pack('C2N*')
      end

      def len
        @payload.size * 8
      end

      def payload=(address)
        address.map! do |ip|
          if ip.is_a?Net::Address::IPv4
            ip
          elsif ip.is_a?Array
            Net::Address::IPv4.new(*ip)
          else
            Net::Address::IPv4.new(ip)
          end
        end
        @payload = address
      end

      def <<(address)
        address.map! do |ip|
          if ip.is_a? Net::Address::IPv4
            ip
          elsif ip.is_a?Array
            Net::Address::IPv4.new(*ip)
          else
            Net::Address::IPv4.new(ip)
          end
        end
        @payload << address
      end

      private

      def self.unpack(oid, len, payload)
        raise ArgumentError, "OID Mismatch for POLICYFILTER Option - #{oid}" unless oid.to_i == POLICY_FILTER
        raise ArgumentError, "Wrong POLICYFILTER Option length - #{len}" unless (len%8) == 0
        address = payload.to_s.unpack('N*')
        i = 0
        a = []

        while i <= (len/8)
          a << Net::Address::IPv4.new(address[i], address[i+1])
          i += 2
        end
        self.new *a
      end

    end
  end
end