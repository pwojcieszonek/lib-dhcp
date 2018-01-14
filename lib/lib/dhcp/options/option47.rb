#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/raw'

module Lib
  module DHCP
    class Option47 < Option
      # NetBIOS over TCP/IP Scope Option, The code for this option is 47.  The minimum length of this option is 1
      # TODO Option 47
      include Lib::DHCP::Option::Type::Raw
    end
  end
end