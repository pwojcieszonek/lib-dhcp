#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 23.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_array'

module Lib
  module DHCP
    class Option73 < Option
      # Default Finger Server Option The code for the Finger server option is 73.
      # The minimum length for this option is 4 octets, and the length MUST always be a multiple of 4
      include Type::IPArray
    end
  end
end