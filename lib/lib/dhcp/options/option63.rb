#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/raw'

module Lib
  module DHCP
    class Option63 < Option
      #TODO Option 63
      include Lib::DHCP::Option::Type::Raw
    end
  end
end