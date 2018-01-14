#Author: Piotr Wojcieszonek
#e-mail: piotrk@wojcieszonek.pl
# Copyright 21.03.2016 by Piotr Wojcieszonek

require 'lib/dhcp/options/option'
require 'lib/dhcp/options/type/netmask'

module Lib
  module DHCP
    class Option1 < Option
      #  Subnet Mask length is 4 octets

      include Type::Netmask

      alias_method :subnet_mask, :payload
      alias_method :mask, :payload
      alias_method :netmask, :payload
      alias_method :subnet_mask, :payload
      alias_method :mask=, :payload=
      alias_method :netmask=, :payload=

    end
  end
end