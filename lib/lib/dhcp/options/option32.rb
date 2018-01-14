#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_address'

module Lib
  module DHCP
    class Option32 < Option
      # Router Solicitation Address Option, The code for this option is 32, and its length is 4.
      include Type::IPAddress
      alias_method :router_solicitation_address, :payload
      alias_method :router_solicitation_address=, :payload=
    end
  end
end