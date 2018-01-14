#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_array'

module Lib
  module DHCP
    class Option48 < Option
      # X Window System Font Server Option, The code for this option is 48.
      # The minimum length of this option is 4 octets, and the length MUST be a multiple of 4.
      include Type::IPArray
    end
  end
end