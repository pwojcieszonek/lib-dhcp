#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.03.2016 by Piotr Wojcieszonek


require_relative 'option'
require_relative 'type/string'

module Lib
  module DHCP
    class Option14 < Option
      # Merit Dump File, This option specifies the path-name of a file to which the client's core image should be
      # dumped in the event the client crashes. The code for this option is 14.  Its minimum length is 1.

      include Type::String

      alias_method :merit_dump_file, :payload
      alias_method :merit_dump_file=, :payload=
    end
  end
end