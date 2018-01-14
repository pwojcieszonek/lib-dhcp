#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 23.03.2016 by Piotr Wojcieszonek



require_relative 'option'
require_relative 'type/sub_option'

module Lib
  module DHCP
    class Option82 < Option
      # DHCP Relay Agent Information Option https://www.ietf.org/rfc/rfc3046.txt
      # SUB OPTION 9 https://tools.ietf.org/html/rfc4243

      include Type::SubOption

    end
  end
end