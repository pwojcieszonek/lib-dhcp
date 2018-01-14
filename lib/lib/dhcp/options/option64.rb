#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/string'

module Lib
  module DHCP
    class Option64 < Option
      # Network Information Service+ Domain Option The code for this option is 64.  Its minimum length is 1.

      include Type::String

      alias_method :nis_domain, :payload
      alias_method :nis_domain=, :payload=
    end
  end
end