#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 25.03.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'

class Offer < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    options = []
    options << Lib::DHCP::Option51.new(3600)
    options << Lib::DHCP::Option54.new('10.0.0.2')
    @offer = Lib::DHCP::Message::Offer.new(chaddr: '00:11:22:33:44:55', yiaddr: '10.0.0.1', options: options)
  end

  def test_sanity_check
    assert_nil  @offer.send(:sanity_check)
  end

  def test_message_type
    assert_equal 2, @offer.option53.to_i
  end

  def test_op_code
    assert_equal 2, @offer.op.to_i
  end

  def test_pack
    packed = Lib::BOOTP::Packet.new(op:2 , yiaddr:'10.0.0.1', chaddr: '00:11:22:33:44:55', xid: @offer.xid).pack
    packed += [0x63825363.to_i].pack('N')
    packed += [53,1,2].pack('C3')
    packed += [51,4,3600].pack('C2N')
    packed += [54,4,167772162].pack('C2N')
    packed += [255].pack('C')
    (1..48).each do
      packed += [0].pack('C')
    end
    assert_equal packed, @offer.pack
  end

  def test_sanity_check_yiaddr
    offer = @offer.dup
    offer.yiaddr= 0
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

  def test_sanity_check_option51
    offer = @offer.dup
    offer.options.del(51)
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

  def test_sanity_check_option54
    offer = @offer.dup
    offer.options.del(54)
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

  def test_sanity_check_option50
    offer = @offer.dup
    offer.option50 = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

  def test_sanity_check_option55
    offer = @offer.dup
    offer.option55 = [1,2,3]
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

  def test_snity_check_option57
    offer = @offer.dup
    offer.option57 = 800
    assert_raises Lib::DHCP::SanityCheck::Offer do
      offer.send(:sanity_check)
    end
  end

end