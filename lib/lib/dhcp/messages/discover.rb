#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 24.03.2016 by Piotr Wojcieszonek


require 'lib/dhcp'

module Lib
  module DHCP
    class Message
      class Discover < Message
        def initialize(htype: 1, hlen: 6, hops: 0, xid: nil, secs: 0, flags: 0, ciaddr: 0, yiaddr: 0, siaddr: 0, giaddr: 0, chaddr: , sname: '.', file: '.', options:nil)
          super(
              :op     => BOOTREQUEST,
              :htype  => htype,
              :hlen   => hlen,
              :hops   => hops,
              :xid    => xid,
              :secs   => secs,
              :flags  => flags,
              :ciaddr => ciaddr,
              :yiaddr => yiaddr,
              :siaddr => siaddr,
              :giaddr => giaddr,
              :chaddr => chaddr,
              :sname  => sname,
              :file   => file
          )
          if options.is_a? Array or options.is_a? Lib::DHCP::Options
            options.each { |option| self.options.add option unless option.oid.to_i == Option::MESSAGE_TYPE }
          elsif options.is_a? Lib::DHCP::Option
            self.options.add options
          elsif !options.nil?
            raise TypeError, "Can't convert #{options.class.name} to Lib::DHCP::Option"
          end
          self.options.add Lib::DHCP::Option53.new(DISCOVER)
        end

        def pack
          # noinspection RubyResolve
          self.option53 = DISCOVER
          self.op       = BOOTREQUEST
          sanity_check
          super
        end

        def self.unpack(packet)
          res = super(packet)
          raise TypeError,  "No implicit conversion of #{res.class.name} into #{self.class.name}" unless res.is_a? self.class
          res
        end

        protected :op=
        # noinspection RubyResolve
        protected :option53=

        protected

        def sanity_check
          # noinspection RubyResolve
          #raise Lib::DHCP::SanityCheck::Discover, "Wrong DHCP message type #{option53.value} for Discover\n #{self.to_s}" unless option53.value.to_i == DHCP_DISCOVER
          raise Lib::DHCP::SanityCheck::Discover, "YIADDR set for DHCP Discover\n #{self.to_s}" unless yiaddr.to_i == 0
          raise Lib::DHCP::SanityCheck::Discover, "CIADDR set for DHCP Discovery\n #{self.to_s}" unless ciaddr.to_i == 0
          # noinspection RubyResolve
          raise Lib::DHCP::SanityCheck::Discover, "Server identifier option set for DHCP Discover Message\n #{self.to_s}" unless option54.nil?
        end
      end
    end
  end
end