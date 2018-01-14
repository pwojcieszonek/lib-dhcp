#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_array'

module Lib
  module DHCP
    class Option44 < Option
      # NetBIOS over TCP/IP Name Server Option, The code for this option is 44.
      # The minimum length of the option is 4 octets, and the length must always be a multiple of 4.
      include Type::IPArray
    end
  end
end