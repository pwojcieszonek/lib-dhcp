#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek



require_relative 'option'
require_relative 'type/raw'

module Lib
  module DHCP
    class Option25 < Option
      # Path MTU Plateau Table Option, The code for this option is 25.  Its minimum length is 2,
      # and the length MUST be a multiple of 2.

      # TODO Option25
      include Lib::DHCP::Option::Type::Raw
    end
  end
end