#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/string'

module Lib
  module DHCP
    class Option17 < Option
      # Root Path, The code for this option is 17.  Its minimum length is 1.
      # This option specifies the path-name that contains the client's root disk.
      # The path is formatted as a character string consisting of characters from the NVT ASCII character set.

      include Type::String

      alias_method :root_path, :payload
      alias_method :root_path=, :payload=
    end
  end
end