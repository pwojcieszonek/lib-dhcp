#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 23.03.2016 by Piotr Wojcieszonek



require_relative 'option'
require_relative 'type/ip_address'
require_relative 'type/string'
require_relative 'type/bool'



module Lib
  module DHCP
    class Option122 < Option

      def initialize(*sub_option)
        oid = self.class.name.split('::').last.sub(/Option/, '').to_i
        sub_options = []
        sub_option.each do |sub|
          if sub.is_a? Lib::DHCP::Option
            opt = sub
          elsif sub.is_a? Array
            case sub[0].to_i
              when 1
                opt = Lib::DHCP::Option122::SubOption::Option1.new(sub[1])
              when 2
                opt = Lib::DHCP::Option122::SubOption::Option2.new(sub[1])
              when 3
                opt = Lib::DHCP::Option122::SubOption::Option3.new(sub[1])
              when 4
                opt = Lib::DHCP::Option122::SubOption::Option4.new(*sub[1])
              when 5
                opt = Lib::DHCP::Option122::SubOption::Option5.new(*sub[1])
              when 6
                opt = Lib::DHCP::Option122::SubOption::Option6.new(sub[1])
              when 7
                opt = Lib::DHCP::Option122::SubOption::Option7.new(sub[1])
              when 8
                opt = Lib::DHCP::Option122::SubOption::Option8.new(sub[1])
              else
                #raise ArgumentError, "Not implemented sub option #{sub[0]} for Option 122"
                opt = Lib::DHCP::Option122::SubOption::Option.new(sub[0].to_i, sub[1])
            end
            #opt = Lib::DHCP::SubOption.new(sub[0], sub[1])
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
        #"Option #{@oid}, LEN #{self.len}, Value #{@payload.to_s}"
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


      def self.unpack(oid, len, payload)
        raise ArgumentError, "Wrong Option #{Lib::DHCP::Option::NAME[oid]} length - #{len}" unless len > 0
        i = 0
        sub_options = []
        while i < len
          sub_oid, sub_len = payload.unpack("@#{i}C2")
          sub_payload = payload.unpack("@#{i+2}a#{sub_len}").first.to_s
          raise ArgumentError "Unknown OID format for DHCP  Option122 SubOption - #{sub_oid}" unless sub_oid.respond_to? :to_i
          raise ArgumentError, "Unknown OID for Option122 SubOption - #{sub_oid}" unless sub_oid.to_i > 0 and sub_oid.to_i < 255
          sub_options << eval("Lib::DHCP::Option122::SubOption::Option#{sub_oid.to_i.to_s}").unpack(sub_oid, sub_len, sub_payload)
          # case sub_oid
          #   when 1
          #     sub_options << Lib::DHCP::Option122::SubOption::Option1.unpack(sub_oid, sub_len, sub_payload)
          #   when 2
          #
          # end
          # sub_options << [sub_oid, sub_payload]
          i += (sub_len + 2)
        end
        self.new *sub_options
      end


      module SubOption

        class Option < ::Lib::DHCP::Option ; end

        class Option1 < Option

          include Lib::DHCP::Option::Type::IPAddress

          def name
            "TSP's DHCP Server Address Sub-Options"
          end
        end

        class Option2 < Option

          include Lib::DHCP::Option::Type::IPAddress

          def name
            "TSP's Secondary DHCP Server Address"
          end
        end

        class Option3 < Option

          attr_reader :type

          def initialize(tsp_server_address)
            @oid = 3

            case tsp_server_address
              when Net::Address::IPv4
                @type = 1
                @payload = tsp_server_address
              when String
                begin
                  @payload = Net::Address::IPv4.new(tsp_server_address)
                  @type = 1
                rescue ArgumentError
                  @type = 0
                  @payload = tsp_server_address
                end
              else
                raise ArgumentError, 'Unknown TSP Provisioning Server Address type'
            end
          end

          def name
            "TSP's Provisioning Server Address Sub-Option"
          end

          def len
            if type == 1
              5
            else
              @payload.to_s.split('.').map{|label| [label.length, label.unpack('C*')]}.flatten.size + 2
              #@payload.size + 1
            end
          end

          def pack
            if @type == 1
              [@oid.to_i, self.len.to_i, 1, @payload.to_i].pack('C3N')
            elsif @type == 0
              fqdn_encode = @payload.to_s.split('.').map{|label| [label.length, label.unpack('C*')]}.flatten
              [@oid.to_i, fqdn_encode.size + 2, 0, *fqdn_encode,0].pack('C*')
            else
              raise ArgumentError, 'Unknown TSP Provisioning Server Address type'
            end
          end

          def self.unpack(oid, len, payload)
            raise ArgumentError, "OID mismatch, require 3, #{oid} given" unless oid == 3
            type = payload.unpack('C').first.to_i
            if type == 1
              raise ArgumentError, "Wrong TSP's Provisioning Server Address Sub-Option length for type 1. Should by 5 but #{len} given" unless len == 5
              self.new Net::Address::IPv4.new(payload.unpack('@N').first)
            elsif type == 0
              self.new payload.unpack('@a*').first
            else
              raise ArgumentError, "Unknown TSP's Provisioning Server Address Sub-Option type #{type}"
            end
          end

        end

        class Option4 < Option
          attr_accessor :nom_timeout, :max_timeout, :max_retries

          def initialize(nom_timeout, max_timeout, max_retries)
            @oid = 4
            @nom_timeout = nom_timeout
            @max_timeout = max_timeout
            @max_retries = max_retries
          end

          def name
            "TSP's AS-REQ/AS-REP Backoff and Retry"
          end

          def payload
            [@nom_timeout, @max_timeout, @max_retries]
          end

          def to_s
            "#{@nom_timeout}, #{@max_timeout}, #{@max_retries}"
          end

          def to_i
            nil
          end

          def pack
            [4, 12, @nom_timeout.to_i, @max_timeout.to_i, @max_retries.to_i].pack('C2N3')
          end

          def self.unpack(oid, len, payload)
            raise ArgumentError, "OID mismatch for TSP's AS-REQ/AS-REP Backoff and Retry, require 4, #{oid} given" unless oid == 4
            raise ArgumentError, "Wrong  length for TSP's AS-REQ/AS-REP Backoff and Retry = #{len}" unless len == 12
            nom_timeout, max_timeout, max_retries = payload.unpack('N3')
            self.new nom_timeout, max_timeout, max_retries
          end

        end

        class Option5 < Option
          attr_accessor :nom_timeout, :max_timeout, :max_retries

          def initialize(nom_timeout, max_timeout, max_retries)
            @oid = 5
            @nom_timeout = nom_timeout
            @max_timeout = max_timeout
            @max_retries = max_retries
          end

          def name
            "TSP's AP-REQ/AP-REP Backoff and Retry"
          end

          def payload
            [@nom_timeout, @max_timeout, @max_retries]
          end

          def to_s
            "#{@nom_timeout}, #{@max_timeout}, #{@max_retries}"
          end

          def to_i
            nil
          end

          def pack
            [5, 12, @nom_timeout.to_i, @max_timeout.to_i, @max_retries.to_i].pack('C2N3')
          end

          def self.unpack(oid, len, payload)
            raise ArgumentError, "OID mismatch for TSP's AP-REQ/AP-REP Backoff and Retry, require 5, #{oid} given" unless oid == 5
            raise ArgumentError, "Wrong  length for TSP's AP-REQ/AP-REP Backoff and Retry = #{len}" unless len == 12
            nom_timeout, max_timeout, max_retries = payload.unpack('N3')
            self.new nom_timeout, max_timeout, max_retries
          end

        end

        class Option6 < Option
          #include Lib::DHCP::Option::Type::String

          def initialize(message)
            oid = self.class.name.split('::').last.sub(/Option/, '').to_i
            super oid, message.to_s
          end

          def pack
            #[@oid, self.len, @payload.to_s].pack('C2a')
            fqdn_encode = @payload.to_s.split('.').map{|label| [label.length, label.unpack('C*')]}.flatten
            [6, fqdn_encode.size + 1, *fqdn_encode, 0].pack('C*')
          end

          def len
            @payload.to_s.split('.').map{|label| [label.length, label.unpack('C*')]}.flatten.size + 1
          end

          def payload=(message)
            @payload = message.to_s
          end

          def name
            "TSP's Kerberos Realm Name Sub-Option"
          end

          def self.unpack(oid, len, payload)
            raise ArgumentError, "Wrong #{Lib::DHCP::Option::NAME[oid]} Option length - #{len}" unless len > 0
            self.new payload#.unpack('a*').first.to_s
          end

        end

        class Option7 < Option
          include Lib::DHCP::Option::Type::BOOL

          def name
            "TSP's Ticket Granting Server Utilization Sub-Option"
          end
        end

        class Option8 < Option
          def initialize(timer)
            @oid = 8
            @payload = timer.to_i
          end

          def len
            1
          end

          def pack
            [8, 1, @payload.to_i].pack('C3')
          end

          def name
            "TSP's Provisioning Timer Sub-Option"
          end

          def self.unpack(oid, len, payload)
            raise ArgumentError, "OID mismatch for TSP's Provisioning Timer Sub-Option, require 8 but #{oid} given" unless oid == 8
            raise ArgumentError, "Wrong TSP's Provisioning Timer Sub-Option length = #{len}" unless len == 1
            self.new payload.unpack('C').first.to_i
          end

        end
      end
    end
  end
end
