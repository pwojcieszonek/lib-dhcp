#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/string'


module Lib
  module DHCP
    class Option18 < Option
      # Extensions Path, The code for this option is 18.  Its minimum length is 1.
      # A string to specify a file, retrievable via TFTP, which contains information which can be
      # interpreted in the same way as the 64-octet vendor-extension field within the BOOTP response

      include Type::String

      alias_method :extension_path, :payload
      alias_method :extension_path=, :payload=
    end
  end
end