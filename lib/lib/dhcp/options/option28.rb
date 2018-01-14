#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_address'

module Lib
  module DHCP
    class Option28 < Option
      # Broadcast Address Option, The code for this option is 28, and its length is 4.

      include Type::IPAddress

      alias_method :broadcast, :payload
      alias_method :broadcast=, :payload=

    end
  end
end