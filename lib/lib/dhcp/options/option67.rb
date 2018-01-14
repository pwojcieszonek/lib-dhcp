#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/string'

module Lib
  module DHCP
    class Option67 < Option
      # Bootfile name The code for this option is 67, and its minimum length is 1.
      include Type::String
      alias_method :boot_file_name, :payload
      alias_method :boot_file_name=, :payload=
      alias_method :boot_file, :payload
      alias_method :boot_file=, :payload=
    end
  end
end