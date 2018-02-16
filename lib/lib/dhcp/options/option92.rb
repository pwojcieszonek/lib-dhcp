#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 23.03.2016 by Piotr Wojcieszonek



require_relative 'option'
require 'lib/dhcp/options/type/ip_array'

module Lib
  module DHCP
    class Option92 < Option

      # This option is used to return all of the IP addresses
      # associated with the DHCP client specified in a particular DHCPLEASEQUERY message.
      # The code for this option is 92.  The minimum length for this option is 4 octets,
      # and the length MUST always be a multiple of 4.

      include Type::IPArray

      alias_method :associated_ip, :payload
      alias_method :associated_ip=, :payload=
    end
  end
end
