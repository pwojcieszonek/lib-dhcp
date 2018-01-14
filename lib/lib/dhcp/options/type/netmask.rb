#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.03.2016 by Piotr Wojcieszonek


require 'net/address'

module Lib
  module DHCP
    class Option
      module Type
        module Netmask
          def self.included(base)
            base.send :include, InstanceMethods
            base.extend ClassMethods
          end

          def initialize(netmask)
            oid = self.class.name.split('::').last.sub(/Option/, '').to_i
            payload = (netmask.is_a?(Net::Address::Mask)) ? netmask : Net::Address::Mask.new(netmask)
            super oid, payload
          end

          module InstanceMethods
            def pack
              [@oid, 4, @payload.to_i].pack('C2N')
            end

            def len
              4
            end

            def to_s
              @payload.to_s
            end

            def payload=(netmask)
              (netmask.is_a? Net::Address::Mask) ? @payload = netmask : @payload = Net::Address::Mask.new(netmask)
            end

          end

          module ClassMethods

            private
            def unpack(oid, len, payload)
              raise ArgumentError, "Wrong #{Lib::DHCP::Option::NAME[oid]} Option length - #{len}" unless len == 4
              self.new *payload.unpack('N*')
            end

          end
        end
      end
    end
  end
end