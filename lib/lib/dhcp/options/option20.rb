#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/bool'

module Lib
  module DHCP
    class Option20 < Option
      # Non-Local Source Routing Enable/Disable Option The code for this option is 20, and its length is 1.

      include Type::BOOL

      alias_method :non_local_routing, :payload
      alias_method :src_route, :payload
      alias_method :non_local_routing=, :payload=
      alias_method :src_route=, :payload=
    end
  end
end