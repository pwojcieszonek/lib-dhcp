#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/bool'

module Lib
  module DHCP
    class Option31 < Option
      # Perform Router Discovery Option, The code for this option is 31, and its length is 1.
      include Type::BOOL
    end
  end
end