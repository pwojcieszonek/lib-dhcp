#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/string'

module Lib
  module DHCP
    class Option15 < Option
      # Domain Name The code for this option is 15.  Its minimum length is 1.

      include Type::String

      alias_method :domain_name, :payload
      alias_method :domain_name=, :payload=
    end
  end
end