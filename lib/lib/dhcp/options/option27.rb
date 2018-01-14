#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/bool'

module Lib
  module DHCP
    class Option27 < Option
      # All Subnets are Local Option , The code for this option is 27, and its length is 1.
      include Type::BOOL
    end
  end
end