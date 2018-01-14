#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/sub_option'

module Lib
  module DHCP
    class Option43 < Option
      # Vendor Specific Information, The code for this option is 43 and its minimum length is 1.
      include Type::SubOption
    end
  end
end
