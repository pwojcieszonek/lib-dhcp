#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require 'lib/dhcp/options/option'
require 'lib/dhcp/options/type/ip_array'


module Lib
  module DHCP
    class Option3 < Option
      #Router Option The minimum length for the router option is 4 octets, and the length MUST always be
      #a multiple of 4 Multiple IP ADDRESS

      include Type::IPArray

      alias_method :router_address, :payload
      alias_method :router_address=, :payload=
    end
  end
end