#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/string'

module Lib
  module DHCP
    class Option60 < Option
      # Vendor class identifier The code for this option is 60, and its minimum length is 1.
      include Type::String
    end
  end
end