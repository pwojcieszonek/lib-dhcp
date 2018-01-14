#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.12.2017 by Piotr Wojcieszonek

require 'forwardable'

module Lib
  module DHCP
    class Options

      attr_reader :options

      extend Forwardable

      def_delegators :@options, :map, :map!, :[], :each

      def initialize(*options)
        @options = []
        options.each { |option| self.add option }
      end

      def pack
        self.map{|option| option.pack}.join('')
      end

      def add(option)
        if option.is_a? Array
          @options << eval("Lib::DHCP::Option#{option[0]}").new(option[1])
        elsif option.is_a? Option
          @options << option
        else
          @options << Lib::DHCP::Option.unpack(option)
        end
      end

      def []=(index, option)
        if option.is_a? Array
          @options[index] = eval("Lib::DHCP::Option#{option[0]}").new(option[1])
        elsif option.is_a? Option
          @options[index] = option
        else
          @options << Lib::DHCP::Option.unpack(option)
        end
      end

      def select(oid)
        @options.select {|option| option.oid.to_i == oid.to_i}
      end

      def del(oid)
        @options.delete_if{|option| option.oid.to_i == oid.to_i}
      end

      alias_method :<<, :add

      def self.unpack(packet)
        size = packet.size
        offset = 0
        options = self.new
        while offset < size
          payload = packet.unpack("@#{offset}a*").first
          option = Lib::DHCP::Option.unpack(payload)
          options << option
          break if option.oid == Lib::DHCP::Option::END_OPTION
          offset += (option.len.to_i + 2)
          #(option.oid == 0 or option.oid == 255) ? offset += (option.len.to_i + 1) : offset += (option.len.to_i + 2)
        end
        options
      end

    end
  end
end
