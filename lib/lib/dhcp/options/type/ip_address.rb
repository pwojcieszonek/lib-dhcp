#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require 'net/address'

module Lib
  module DHCP
    class Option
      module Type
        module IPAddress
          def self.included(base)
            base.extend ClassMethods
          end

          def initialize(*address)
            raise ArgumentError, 'To few argument - nil' if address.nil?
            oid = self.class.name.split('::').last.sub(/Option/, '').to_i
            if address.size == 1
              address = address.first.split(',') if address.first.is_a? ::String
            end
            case address.size
              when 0
                raise ArgumentError, 'To few argument - 0'
              when 1
                address = address.first
                super oid, (address.is_a? Net::Address::IPv4) ? address : Net::Address::IPv4.new(address)
              else
                super oid, address.map {|ip| (ip.is_a? Net::Address::IPv4) ? ip : Net::Address::IPv4.new(ip)}
            end
          end

          def to_s
            @payload.to_s
          end

          def pack
            if @payload.is_a? Array
              #len = @payload.size * 4
              [@oid, len, @payload.map(&:to_i)].flatten.pack('C2N*')
            else
              raise ArgumentError, 'Argument must be a IP ' unless @payload.is_a? Net::Address::IPv4
              [@oid, 4, @payload.to_i].pack('C2N')
            end
          end

          def len
            if @payload.is_a? Array
              @payload.size * 4
            else
              4
            end
          end

          def payload=(address)
            (address.is_a? Net::Address::IPv4) ? @payload = address : @payload = Net::Address::IPv4.new(address)
          end


          module ClassMethods
            private
            def unpack(oid, len, payload)
              raise ArgumentError, "Wrong #{Lib::DHCP::Option::NAME[oid]} Option length - #{len}" unless (len % 4) == 0
              self.new *payload.unpack('N*')
            end
          end

        end
      end
    end
  end
end