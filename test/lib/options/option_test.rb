#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 21.03.2016 by Piotr Wojcieszonek


require 'lib/dhcp'


class Option < Minitest::Test

  def test_respond_to_unpack
    assert_respond_to Lib::DHCP::Option, :unpack
  end

  def test_respond_to_len
    assert_respond_to Lib::DHCP::Option.new(0), :len
  end

end