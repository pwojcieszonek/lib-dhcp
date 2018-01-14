#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 23.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/raw'

module Lib
  module DHCP
    class Option87 < Option
      #TODO Option87
      include Lib::DHCP::Option::Type::Raw
    end
  end
end