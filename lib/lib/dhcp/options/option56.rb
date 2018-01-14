#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/string'

module Lib
  module DHCP
    class Option56 < Option
      # Message The code for this option is 56 and its minimum length is 1.

      include Type::String

      alias_method :message, :payload
      alias_method :message=, :payload=
    end
  end
end