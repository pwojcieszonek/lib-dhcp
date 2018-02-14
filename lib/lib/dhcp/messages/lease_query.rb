#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 25.03.2016 by Piotr Wojcieszonek


require 'lib/dhcp'

module Lib
  module DHCP
    class Message
      class LeaseQuery < Message
        def initialize(htype: 1, hlen: 6, hops: 0, xid: nil, secs: 0, flags: 0, ciaddr: 0, yiaddr: 0, siaddr: 0, giaddr: 0, chaddr: , sname: '.', file: '.', options: nil)
          super(
              :op => BOOTREQUEST,
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
          self.options.add Lib::DHCP::Option53.new(LEASE_QUERY)

        end

        def pack
          # noinspection RubyResolve
          self.option53 = LEASE_QUERY
          self.op = BOOTREQUEST
          sanity_check
          super
        end

        def self.unpack(packet)
          res = super(packet)
          raise TypeError, "No implicit conversion of #{res.class.name} into #{self.class.name}" unless res.is_a? self.class
          res
        end

        def query_by_ip?
          (message.ciaddr != 0) ? true : false
        end

        def query_by_mac?
          (message.htype != 0 and message.hlen != 0 and message.chaddr != 0) ? true : false
        end

        def query_by_client_id?
          message.option61.nil? ? false : true
        end

        protected :op=
        # noinspection RubyResolve
        protected :option53=

        protected
        def sanity_check
          if query_by_ip?
            raise Lib::DHCP::SanityCheck::LeaseQuery, 'The values of htype, hlen, and chaddr MUST be set to zero '+
                'in the query by IP' unless self.htype == 0 and self.hlen == 0  and self.chaddr != 0
            raise Lib::DHCP::SanityCheck::LeaseQuery, 'The Client-identifier option (option 61) MUST NOT appear in the ' +
                'query by IP'  unless self.option61.nil?
          elsif query_by_mac?
            raise Lib::DHCP::SanityCheck::LeaseQuery, 'The "ciaddr" field MUST be set to zero in the query ' +
                'by MAC address' unless self.ciaddr == 0
            raise Lib::DHCP::SanityCheck::LeaseQuery, 'The Client-identifier option (option 61) MUST NOT appear in the ' +
                'query by MAC'  if self.option61
          elsif query_by_client_id?
            raise Lib::DHCP::SanityCheck::LeaseQuery, 'The "ciaddr" field MUST be set to zero in the query ' +
                'by Client identifier' unless self.ciaddr == 0
            raise Lib::DHCP::SanityCheck::LeaseQuery, 'The values of htype, hlen, and chaddr MUST be set to zero in ' +
                'the query by Client identifier' unless self.htype == 0 or self.hlen == 0  and self.chaddr != 0
          else
            raise Lib::DHCP::SanityCheck::LeaseQuery, 'Unknown query type'
          end
        end
      end
    end
  end
end
