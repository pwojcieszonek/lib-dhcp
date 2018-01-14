#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_address'

module Lib
  module DHCP
    class Option16 < Option
      # Swap Server, The code for this option is 16 and its length is 4. 1 IP ADDRESS
      include Type::IPAddress

      alias_method :swap_server, :payload
      alias_method :swap_server=, :payload=
    end
  end
end