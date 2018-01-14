#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/raw'

module Lib
  module DHCP
    class Option68 < Option
      #TODO Option 68
      # Mobile IP Home Agent option, The code for this option is 68.
      # Its minimum length is 0 (indicating no home agents are available) and the length MUST be a multiple of 4.
      # It is expected that the usual length will be four octets, containing a single home agent's address.
      include Lib::DHCP::Option::Type::Raw
    end
  end
end