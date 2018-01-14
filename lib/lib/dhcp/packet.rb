#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.12.2017 by Piotr Wojcieszonek

require 'lib/bootp'
require 'forwardable'


module Lib
  module DHCP
    class Packet < Lib::BOOTP::Packet

      MAGICK_COOKIE = 0x63825363

      (1..254).each do |i|

        define_method("option#{i}") do
          self.options.select(i.to_i).first
        end

        define_method("option#{i}=") do |payload|
          self.options.del(i) if self.options.select(i)
          if payload.is_a? Lib::DHCP::Option
            self.options.add payload
          else
            self.options.add [i,payload]
          end
        end

      end

      def option0
        self.options.select 0
      end

      def option255
        self.options.select 255
      end

      def to_s
        str = super()
        str += "\nMAGICK-COOKIE      : 0x#{MAGICK_COOKIE.to_s(16)}"
        str += "\n\n  --- DHCP OPTIONS ---\n"
        options.each do |o|
          if o.value.is_a? Array
            value = o.value.map(&:to_s).join(',')
          else
            value = o.value
          end
          str += "\nOption #{o.oid.to_s.ljust(3,' ')} : LEN #{o.len.to_s.ljust(3, ' ')} #{o.name.to_s.ljust(40, ' ')}  : #{value}"
        end
        str += "\n\n"
        str
      end

      def options
        @options ||= Lib::DHCP::Options.new
      end

      def self.unpack(packet)
        bootp, cookie, options = packet.unpack('a236Na*')
        raise RuntimeError, "Magick-Cookie mismatch #{cookie.to_i.to_s(16)}" unless cookie.to_i == MAGICK_COOKIE.to_i
        dhcp = super bootp
        dhcp.instance_variable_set(:@options, Lib::DHCP::Options.unpack(options))
        dhcp
      end

      def pack
        # TODO Max Message Size support
        dhcp_message = super # BOOTP Header
        dhcp_message += [MAGICK_COOKIE].pack('N')
        raise ArgumentError, "Can't pack DHCP Packet without DHCP Message Type" if self.option53.nil?
        dhcp_message += self.option53.pack # Option 53 (DHCP MESSAGE TYPE) must be first in message

        len = 240 # 236 BOOTP HEADER + 3 (Option 53) + 1 (Option 255)
        self.options.each do |option|
          unless option.oid.to_i == 0 or option.oid.to_i == 255 or option.oid.to_i == 53
            # TODO Pack RAW Option
            # TODO Need to test RAW Option packing
            # next if option.is_a? Lib::DHCP::Option::Type::Raw # Don't pack not implemented Option type
            dhcp_message += option.pack
            len += (option.len.to_i + 2) # Option ID + Option LEN + Option PAYLOAD
          end
        end
        dhcp_message += Lib::DHCP::Option255.new.pack
        while len < 300 # Minimal DHCP MESSAGE SIZE
          dhcp_message += Lib::DHCP::Option0.new.pack
          len += 1
        end
        dhcp_message
      end

    end
      
  end
end
