#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_address'

module Lib
  module DHCP
    class Option50 < Option
      # Requested IP Address The code for this option is 50, and its length is 4.
      include Type::IPAddress
    end
  end
end