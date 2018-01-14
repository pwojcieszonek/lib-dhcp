#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_array'

module Lib
  module DHCP
    class Option69 < Option
      # Simple Mail Transport Protocol (SMTP) Server Option The code for the SMTP server option is 69.
      # The minimum length for this option is 4 octets, and the length MUST always be a multiple of 4
      include Type::IPArray
    end
  end
end