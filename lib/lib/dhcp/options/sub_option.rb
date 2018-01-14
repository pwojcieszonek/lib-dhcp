#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'

module Lib
  module DHCP
    class SubOption < Option

      def name
        option = self.class.name.split('::')[-2]
        sub_option = "#{self.class.name.split('::').last}#{@oid}"
        "#{option} #{sub_option}"
      end

      def to_s
        @payload.unpack('C*').map{|item| item.to_i.to_s(16).rjust(2, '0') }.join(':')
      end

      def len
        [@payload].pack('a*').size
      end

      def pack
        [@oid.to_i, len.to_i, @payload].pack('C2a*')
      end

    end
  end
end