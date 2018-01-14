#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 22.12.2017 by Piotr Wojcieszonek

module Lib
  module DHCP
    class Exception < ::Exception ; end
    class SanityCheck < Exception
      class Discover < self ; end

      class Offer < self ; end

      class Request < self ; end

      class ACK < self ; end

      class NACK < self ; end

      class Inform < self ; end

      class Decline < self ; end

      class Release < self ; end

      class LeaseQuery < self ; end

      class LeaseUnassigned < self ; end

      class LeaseUnknown < self ; end

      class LeaseActive < self ; end
    end
  end
end