#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require 'lib/dhcp/options/sub_option'


module Lib
  module DHCP
    class Option
      module Type
        module SubOption

          def self.included(base)
            base.extend ClassMethods
          end

          def initialize(*sub_option)
            oid = self.class.name.split('::').last.sub(/Option/, '').to_i
            sub_options = []
            sub_option.each do |sub|
              if sub.is_a? Lib::DHCP::SubOption
                opt =  sub
              elsif sub.is_a? Array
                opt = Lib::DHCP::SubOption.new(sub[0], sub[1])
              else
                raise ArgumentError, 'Unknown SubOption parameter type'
              end
              sub_options << opt
              define_singleton_method("option#{opt.oid.to_i}".to_sym) { opt }
              #define_singleton_method(:option1) {opt}
            end
            super oid, sub_options
          end

          def to_s
            s =''
            @payload.each do |sub_option|
              s += "Option #{sub_option.oid}, LEN #{sub_option.len}, Value #{@payload.to_s} \n\r"
            end
            s
          end

          def len
            l = 0
            @payload.each do |sub_option|
              l += (sub_option.len.to_i + 2).to_i
            end
            l
          end

          def pack
            option_pack = ''
            sub_len = 2
            @payload.each do |sub_option|
              sub_len += sub_option.len
              option_pack += sub_option.pack
            end
            [@oid, self.len, option_pack].pack('C2a*')
          end

          module ClassMethods

            def unpack(oid, len, payload)
              raise ArgumentError, "Wrong Option #{Lib::DHCP::Option::NAME[oid]} length - #{len}" unless len > 0
              i = 0
              sub_options = []
              while i < len
                sub_oid, sub_len = payload.unpack("@#{i}C2")
                sub_payload = payload.unpack("@#{i+2}a#{sub_len}").first.to_s
                sub_options << [sub_oid, sub_payload]
                i += (sub_len + 2)
              end
              self.new *sub_options
            end

          end
        end
      end
    end
  end
end