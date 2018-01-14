#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_array'

module Lib
  module DHCP
    class Option42 < Option
      # Network Time Protocol Servers Option, The code for this option is 42.
      # Its minimum length is 4, and the length MUST be a multiple of 4.

      include Type::IPArray

      alias_method :ntp_server, :payload
      alias_method :ntp_server=, :payload=

    end
  end
end