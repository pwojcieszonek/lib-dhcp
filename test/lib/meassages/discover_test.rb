#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 25.03.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'

class Discover < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @discover = Lib::DHCP::Message::Discover.new(chaddr: '00:11:22:33:44:55')
  end

  def test_message_type
    assert_equal 1, @discover.option53.to_i
  end

  def test_op_code
    assert_equal 1, @discover.op.to_i
  end

  def test_sanity_check
    assert_nil  @discover.send(:sanity_check)
  end

  def test_sanity_check_yiaddr
    discover = @discover.dup
    discover.yiaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Discover do
      discover.send(:sanity_check)
    end
  end

  def test_sanity_check_ciaddr
    discover = @discover.dup
    discover.ciaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Discover do
      discover.send(:sanity_check)
    end
  end

  def test_sanity_check_option54
    discover = @discover.dup
    discover.options.add Lib::DHCP::Option54.new('10.0.0.1')
    assert_raises Lib::DHCP::SanityCheck::Discover do
      discover.send(:sanity_check)
    end
  end

  def test_pack

    packed = Lib::BOOTP::Packet.new(op:1 , chaddr: '00:11:22:33:44:55', xid: @discover.xid).pack
    packed += [0x63825363.to_i].pack('N')
    packed += [53,1,1].pack('C3')
    packed += [255].pack('C')
    (1..60).each do
      packed += [0].pack('C')
    end
    assert_equal packed, @discover.pack
  end


end