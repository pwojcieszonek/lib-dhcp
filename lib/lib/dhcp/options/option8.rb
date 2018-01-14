#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_array'

module Lib
  module DHCP
    class Option8 < Option
      #  Cookie Server Option, The minimum length for the router option is 4 octets, and the length MUST always be
      # a multiple of 4 Multiple IP ADDRESS

      include Type::IPArray

      alias_method :cookie_server, :payload
      alias_method :cookie_server=, :payload=

    end
  end
end