#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/raw'

module Lib
  module DHCP
    class Option33 < Option
      #Static Route Option, The code for this option is 33.
      # The minimum length of this option is 8, and the length MUST be a multiple of 8.
      # TODO Option 33

      include Lib::DHCP::Option::Type::Raw

    end
  end
end