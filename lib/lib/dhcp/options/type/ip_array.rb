#Author: Piotr Wojcieszonek
#e-mail: piotrk@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require 'lib/dhcp/options/type/ip_address'
require 'net/address'

#TODO Implement :each

module Lib
  module DHCP
    class Option
      module Type
        module IPArray

          def self.included(base)
            base.send :include, Lib::DHCP::Option::Type::IPAddress
          end

          def <<(address)
            unless @payload.is_a? Array
              payload = @payload
              @payload = [] #Array.new
              @payload << payload
            end
            @payload << (address.is_a? Net::Address::IPv4) ? address : Net::Address::IPv4.new(address)
          end

          def payload=(*address)
            address = address.split(',') if address.is_a? String
            @payload = address.map { |ip| (ip.is_a? Net::Address::IPv4) ? ip : Net::Address::IPv4.new(ip) }
          end

          alias_method :add, :<<

        end
      end
    end
  end
end