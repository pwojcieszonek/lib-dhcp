#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.12.2017 by Piotr Wojcieszonek

require 'forwardable'
require 'json'

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
        option = begin
                   JSON.parse(option)
                 rescue JSON::ParserError
                   option
                 rescue TypeError
                   option
                 end
        option = create_option(option)
        @options << option unless self.include? option
      end

      def []=(index, option)
        option = create_option(option)
        if include?(option) and @options[index].oid != option.oid
          @options[index] = option if option.oid == 0
        else
          @options[index] = create_option(option)
        end

      end

      def include?(option)
        return ! select(option.oid).empty? if option.is_a?(Option)
        return ! select(option).empty? if option.is_a?(Integer)
        false
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
        end
        options
      end

      protected

      def create_option(option)
        if option.is_a? Array
          Lib::DHCP.const_get("Option#{option[0].to_i}").new(option[1])
        elsif option.is_a? Option
          option
        elsif option.is_a?(Integer) and (option == 0 or option == 255)
          Lib::DHCP.const_get("Option#{option.to_i}").new
        elsif option.is_a? Hash
          Lib::DHCP.const_get("Option#{option.transform_keys(&:to_sym)[:oid].to_i}").new(option.transform_keys(&:to_sym)[:value])
        else
          Lib::DHCP::Option.unpack(option)
        end
      end

    end
  end
end
