#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_array'

module Lib
  module DHCP
    class Option49 < Option
      # X Window System Display Manager Option, The code for the this option is 49.
      # The minimum length of this optionis 4, and the length MUST be a multiple of 4.
      include Type::IPArray
    end
  end
end