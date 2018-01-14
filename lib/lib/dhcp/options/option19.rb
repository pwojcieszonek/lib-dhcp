#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/bool'

module Lib
  module DHCP
    class Option19 < Option
      # IP Forwarding Enable/Disable Option, The code for this option is 19, and its length is 1.

      include Type::BOOL

      alias_method :ip_forward, :payload
      alias_method :ip_forward=, :payload=
    end
  end
end