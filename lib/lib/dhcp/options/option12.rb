#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/string'

module Lib
  module DHCP
    class Option12 < Option
      # Host Name Option, The minimum length is 1

      include Type::String

      alias_method :hostname, :payload
      alias_method :hostname=, :payload=
    end
  end
end