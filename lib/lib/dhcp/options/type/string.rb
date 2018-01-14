#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


module Lib
  module DHCP
    class Option
      module Type
        module String
          def self.included(base)
            base.send :include, InstanceMethods
            base.extend ClassMethods
          end

          def initialize(message)
            oid = self.class.name.split('::').last.sub(/Option/, '').to_i
            super oid, message.to_s
          end

          module InstanceMethods
            def pack
              [@oid, @payload.size, @payload.to_s].pack('C2a*')
            end

            def len
              @payload.size
            end

            def to_s
              @payload.to_s
            end

            def payload=(message)
              @payload = message.to_s
            end
          end

          module ClassMethods
            def unpack(oid, len, payload)
              raise ArgumentError, "Wrong #{Lib::DHCP::Option::NAME[oid]} Option length - #{len}" unless len > 0
              self.new payload#.unpack('a*').first.to_s
            end
          end
        end
      end
    end
  end
end