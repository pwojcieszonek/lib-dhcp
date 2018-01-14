#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


module Lib
  module DHCP
    class Option
      module Type
        module BOOL
          def self.included(base)
            base.send :include, InstanceMethods
            base.extend ClassMethods
          end

          def initialize(option)
            if option
              option =  (option > 0) ? 1 : 0
            else
              option = 0
            end
            oid = self.class.name.split('::').last.sub(/Option/, '').to_i
            super oid, option
          end

          module InstanceMethods
            def pack
              [@oid, 1, @payload.to_i].pack('C3')
            end

            def len
              1
            end

            def payload=(option)
              if option
                @payload = (option > 0) ? 1 : 0
              else
                @payload = 0
              end
            end
          end

          module ClassMethods
            private
            def unpack(oid, len, payload)
              raise ArgumentError, "Wrong #{Lib::DHCP::Option::NAME[oid]} length = #{len}" unless len == 1
              self.new payload.unpack('C').first.to_i
            end
          end
        end
      end
    end
  end
end