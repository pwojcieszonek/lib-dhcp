#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/ip_array'

module Lib
  module DHCP
    class Option6 < Option
      # Domain Name Server Option.The minimum length for the router option is 4 octets, and the length MUST always be
      # a multiple of 4 Multiple IP ADDRESS

      include Type::IPArray

      alias_method :domain_name_server, :payload
      alias_method :dns, :payload
      alias_method :domain_name_server=, :payload=
      alias_method :dns=, :payload=
    end
  end
end