#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.12.2017 by Piotr Wojcieszonek

require 'forwardable'


module Lib
  module DHCP
    class Option

      extend Forwardable
      include Comparable

      def_delegators :@payload, :to_i, :to_s

      attr_reader :oid
      attr_accessor :payload

      def initialize(oid, payload = nil)
        @oid = oid
        @payload = payload
      end

      def len
        @len.to_i || 0
      end

      def <=>(other)
        other.is_a?(Lib::DHCP::Option) ? self.value <=> other.value : self.value <=> other
      end

      def pack
        @payload = '' if @value.nil?
        [@oid, @len, @payload.to_s].pack("C2a#{@len.to_i}")
      end


      def to_s
        @payload.to_s.unpack('C*').map{|item| item.to_i.to_s(16).rjust(2, '0') }.join(':')
      end

      def name
        return 'Unknown Option Name' unless NAME.include? @oid.to_i
        NAME[@oid.to_i]
      end

      def to_json(*params)
        self.to_h.to_json
      end

      def to_h
        {
          name: self.name,
          oid: self.oid.to_i,
          len: self.len,
          value: self.value.respond_to?(:map) ? self.value.map { |v| v.respond_to?(:to_h) ? v.to_h : v } : self.value
        }
      end

      def self.from_json(json)
        json = json.is_a?(Hash) ? JSON.parse(json.to_json, symbolize_names: true) : JSON.parse(json, symbolize_names: true)
        Lib::DHCP.const_get("Option#{json.transform_keys(&:to_sym)[:oid].to_i}").new(
          json.transform_keys(&:to_sym)[:value]
        )
      end

      def self.unpack(packet)
        oid, len = packet.unpack('C2')
        payload = nil
        payload = packet.to_s.unpack("@2a#{len.to_s}").first unless oid.to_i == 0 or oid.to_i  == 255
        len = 0 if oid.to_i == 0 or oid.to_i  == 255
        raise ArgumentError "Wrong OID format for DHCP Option - #{oid}" unless oid.respond_to? :to_i
        raise ArgumentError "Wrong OID for DHCP Option = #{oid}" unless oid.to_i >= 0 and oid.to_i < 256
        begin
        eval("Option#{oid.to_i.to_s}").send(:unpack, oid, len, payload.to_s)
        rescue ArgumentError => e
          raise ArgumentError, "OPTION #{oid} : #{e.message}"
        end
      end

      alias_method :value, :payload
      alias_method :value=, :payload=

      PAD = 0x00
      SUBNET_MASK = 0x01
      TIME_OFFSET = 0x02
      ROUTER = 0x03
      TIME_SERVER = 0x04
      NAME_SERVER = 0x05
      DNS_SERVER = 0x06
      LOG_SERVER = 0x07
      COOKIE_SERVER = 0x08
      QUOTE_SERVER = 0x08
      LPR_SERVER = 0x09
      IMP_SERVER = 0x0a
      RES_SERVER = 0x0b
      HOSTNAME = 0x0c
      BOOT_FILE_SIZE = 0x0d
      DUMP_FILE = 0x0e
      DOMAIN_NAME = 0x0f
      SWAP_SERVER = 0x10
      ROOT_PATH = 0x11
      EXTENSION_PATH = 0x12
      IP_FORWARD = 0x13
      SRC_ROUTE = 0x14
      POLICY_FILTER = 0x15
      MAX_REASSEMBLE_SIZE = 0x16
      IP_TTL = 0x17
      MTU_TIMEOUT = 0x18
      MTU_TABLE = 0x19
      MTU_SIZE = 0x1a
      LOCAL_SUBNETS = 0x1b
      BROADCAST_ADDR = 0x1c
      DO_MASK_DISCOVER = 0x1d
      MASK_SUPPLY = 0x1e
      DO_ROUTE_DISCOVER = 0x1f
      ROUTER_SOLICIT = 0x20
      STATIC_ROUTE = 0x21
      TRAILER_ENCAPSULATION = 0x22
      ARP_TIMEOUT = 0x23
      ETHERNET_ENCAPSULATION = 0x24
      TCP_TTL = 0x25
      TCP_KEEP_ALIVE = 0x26
      TCP_ALIVE_GARBAGE =0x27
      NIS_DOMAIN = 0x28
      NIS_SERVERS = 0x29
      NIS_TIME_SERVER = 0x2a
      VENDOR_SPECIFIC = 0x2b
      NBNS = 0x2c
      NBDD= 0x2d
      NETBIOS_TCP_IP= 0x2e
      NETBIOS_TCP_SCOPE= 0x2f
      XFONT= 0x30
      XDISPLAY_MANAGER= 0x31
      REQUESTED_ADDRESS= 0x32
      LEASE_TIME= 0x33
      OPTION_OVERLOAD= 0x34
      MESSAGE_TYPE= 0x35
      SERVER_IDENTIFIER= 0x36
      PARAMETER_REQUEST= 0x37
      MESSAGE= 0x38
      MAX_MESSAGE_SIZE= 0x39
      RENEW_TIME= 0x3a
      REBIND_TIME= 0x3b
      VENDOR_CLASS_IDENTIFIER= 0x3c
      CLIENT_IDENTIFIER= 0x3d
      NIS_DOMAIN_NAME= 0x40
      NIS_SERVER= 0x41
      TFTP_SERVER= 0x42
      BOOT_FILE_NAME= 0x43
      MOBILE_IP_AGENT= 0x44
      SMTP_SERVER= 0x45
      POP3_SERVER= 0x46
      NNTP_SERVER= 0x47
      WWW_SERVER= 0x48
      FINGER_SERVER= 0x49
      IRC_SERVER= 0x4a
      STREET_TALK_SERVER= 0x4b
      STREET_TALK_DIRECTORY_SERVER= 0x4c
      USER_CLASS= 0x4d
      RELAY_AGENT = 0x52
      CLIENT_LAST_TRANSACTION_TIME= 0x5b
      ASSOCIATED_IP = 0x5c
      PRIVATE= 0xaf
      END_OPTION = 0xff

      NAME ={
          0 => 'Pad',
          1 => 'Subnet Mask',
          2 => 'Time Offset',
          3 => 'Router Option',
          4 => 'Time Server Option',
          5 => 'Name Server Option',
          6 => 'Domain Name Server Option',
          7 => 'Log Server Option',
          8 => 'Cookie Server Option',
          9 => 'LPR Server Option',
          10 => 'Impress Server Option',
          11 => 'Resource Location Server Option',
          12 => 'Host Name Option',
          13 => 'Boot File Size Option',
          14 => 'Merit Dump File',
          15 => 'Domain Name',
          16 => 'Swap Server',
          17 => 'Root Path',
          18 => 'Extensions Path',
          19 => 'IP Forwarding Enable/Disable Option',
          20 => 'Non-Local Source Routing Enable/Disable Option',
          21 => 'Policy Filter Option',
          22 => 'Maximum Datagram Reassembly Size',
          23 => 'Default IP Time-to-live',
          24 => 'Path MTU Plateau Table Option',
          25 => 'IP Layer Parameters per Interface',
          26 => 'Interface MTU Option',
          27 => 'All Subnets are Local Option',
          28 => 'Broadcast Address Option',
          29 => 'Perform Mask Discovery Option',
          30 => 'Mask Supplier Option',
          31 => 'Perform Router Discovery Option',
          32 => 'Router Solicitation Address Option',
          33 => 'Static Route Option',
          34 => 'Trailer Encapsulation Option',
          35 => 'ARP Cache Timeout Option',
          36 => 'Ethernet Encapsulation Option',
          37 => 'TCP Default TTL Option',
          38 => 'TCP Keepalive Interval Option',
          39 => 'TCP Keepalive Garbage Option',
          40 => 'Network Information Service Domain Option',
          41 => 'Network Information Servers Option',
          42 => 'Network Time Protocol Servers Option',
          43 => 'Vendor Specific Information',
          44 => 'NetBIOS over TCP/IP Name Server Option',
          45 => 'NetBIOS over TCP/IP Datagram Distribution Server Option',
          46 => 'NetBIOS over TCP/IP Node Type Option',
          47 => 'NetBIOS over TCP/IP Scope Option',
          48 => 'X Window System Font Server Option',
          49 => 'X Window System Display Manager Option',
          50 => 'Requested IP Address',
          51 => 'IP Address Lease Time',
          52 => 'Option Overload',
          53 => 'DHCP Message Type',
          54 => 'Server Identifier',
          55 => 'Parameter Request List',
          56 => 'Message',
          57 => 'Maximum DHCP Message Size',
          58 => 'Renewal (T1) Time Value',
          59 => 'Rebinding (T2) Time Value',
          60 => 'Vendor class identifier',
          61 => 'Client-identifier',
          62 => 'NetWare/IP Domain Name',
          63 => 'NetWare/IP information',
          64 => 'Network Information Service+ Domain Option',
          65 => 'Network Information Service+ Servers Option',
          66 => 'TFTP server name',
          67 => 'Bootfile name',
          68 => 'Mobile IP Home Agent option',
          69 => 'Simple Mail Transport Protocol (SMTP) Server Option',
          70 => 'Post Office Protocol (POP3) Server Option',
          71 => 'Network News Transport Protocol (NNTP) Server Option',
          72 => 'Default World Wide Web (WWW) Server Option',
          73 => 'Default Finger Server Option',
          74 => 'Default Internet Relay Chat (IRC) Server Option',
          75 => 'StreetTalk Server Option',
          76 => 'StreetTalk Directory Assistance (STDA) Server Option',
          77 => 'User Class Information',
          78 => 'SLP Directory Agent',
          79 => 'SLP Service Scope',
          80 => 'Rapid Commit',
          81 => 'FQDN, Fully Qualified Domain Name',
          82 => 'Relay Agent Information',
          83 => 'Internet Storage Name Service',
          84 => '',
          85 => 'NDS servers',
          86 => 'NDS tree name',
          87 => 'NDS context',
          88 => 'BCMCS Controller Domain Name list',
          89 => 'BCMCS Controller IPv4 address list.',
          90 => 'Authentication',
          91 => 'Client last transaction time',
          92 => 'Associated IP',
          93 => 'Client System Architecture Type',
          119 => 'Domain Search',
          121 => 'Classless Static Route Option',
          122 => 'CCC, CableLabs Client Configuration',
          125 => 'Vendor-Identifying Vendor Options',
          255 => 'END'
      }
    end
  end
end