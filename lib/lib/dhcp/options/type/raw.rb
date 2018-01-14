#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek

module Lib
  module DHCP
    class Option
      module Type
        module Raw

          def self.included(base)
            base.extend ClassMethods
          end



            def len=(len)
              @len = len.to_i
            end

            def len
              @len.to_i
            end

            def pack
              @payload = '' if @value.nil?
              [@oid, @len, @payload.to_s].pack("C2a#{@len.to_i}")
            end


            def to_s
              @payload.unpack('C*').map{|item| item.to_i.to_s(16).rjust(2, '0') }.join(':')
            end



          module ClassMethods
            private
            def unpack(oid, len, payload)
              option = self.new oid, payload
              option.len = len.to_i
              option
            end

          end

        end
      end
    end
  end
end