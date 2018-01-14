#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/string'

module Lib
  module DHCP
    class Option66 < Option
      # TFTP server name The code for this option is 66, and its minimum length is 1.
      include Type::String
      alias_method :tftp_server_name, :payload
      alias_method :tftp_server_name=, :payload=
      alias_method :tftp_server, :payload
      alias_method :tftp_server=, :payload=
    end
  end
end