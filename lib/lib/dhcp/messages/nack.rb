#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 25.03.2016 by Piotr Wojcieszonek


require 'lib/dhcp'

module Lib
  module DHCP
    class Message
      class NACK < Message
        def initialize(htype: 1, hlen: 6, hops: 0, xid: nil, secs: 0, flags: 0, ciaddr: 0, yiaddr: 0, siaddr: 0, giaddr: 0, chaddr: 0, sname: '.', file: '.', options: nil)
          if block_given?
            yield self
          else
            super(
              :op => BOOTREPLY,
              :htype => htype,
              :hlen => hlen,
              :hops => hops,
              :xid => xid,
              :secs => secs,
              :flags => flags,
              :ciaddr => ciaddr,
              :yiaddr => yiaddr,
              :siaddr => siaddr,
              :giaddr => giaddr,
              :chaddr => chaddr,
              :sname => sname,
              :file => file
            )
            if options.is_a? Array or options.is_a? Lib::DHCP::Options
              options.each { |option| self.options.add option unless option.oid.to_i == Option::MESSAGE_TYPE }
            elsif options.is_a? Lib::DHCP::Option
              self.options.add options
            elsif !options.nil?
              raise TypeError, "Can't convert #{options.class.name} to Lib::DHCP::Option"
            end
          end
          self.options.add Lib::DHCP::Option53.new(NOT_ACKNOWLEDGE)
        end

        def pack
          # noinspection RubyResolve
          self.option53 = NOT_ACKNOWLEDGE
          self.op = BOOTREPLY
          sanity_check
          super
        end

        def self.unpack(packet)
          res = super(packet)
          raise TypeError, "No implicit conversion of #{res.class.name} into #{self.class.name}" unless res.is_a? self.class
          res
        end

        protected :op=
        # noinspection RubyResolve
        protected :option53=

        protected
        def sanity_check
          #TODO NACK Sanity Check
        end
      end
    end
  end
end