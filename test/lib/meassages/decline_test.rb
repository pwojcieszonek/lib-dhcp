#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 25.03.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'

class Decline < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    options = []
    options << Lib::DHCP::Option50.new('10.0.0.1')
    options << Lib::DHCP::Option54.new('10.0.0.2')
    @decline = Lib::DHCP::Message::Decline.new(chaddr: '00:11:22:33:44:55', options: options)
  end

  def test_sanity_check
    assert_nil  @decline.send(:sanity_check)
  end

  def test_op_code
    assert_equal 1, @decline.op.to_i
  end

  def test_message_type
    assert_equal 4, @decline.option53.to_i
  end

  def test_sanity_check_flags
    decline = @decline.dup
    decline.flags = :broadcast
    assert_raises Lib::DHCP::SanityCheck::Decline do
      decline.send(:sanity_check)
    end
  end

  def test_sanity_check_ciaddr
    decline = @decline.dup
    decline.ciaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Decline do
      decline.send(:sanity_check)
    end
  end

  def test_sanity_check_yiaddr
    decline = @decline.dup
    decline.yiaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Decline do
      decline.send(:sanity_check)
    end
  end

  def test_sanity_check_siaddr
    decline = @decline.dup
    decline.siaddr = '10.0.0.1'
    assert_raises Lib::DHCP::SanityCheck::Decline do
      decline.send(:sanity_check)
    end
  end

  def test_sanity_check_option57
    decline = @decline.dup
    decline.option57 = 800
    assert_raises Lib::DHCP::SanityCheck::Decline do
      decline.send(:sanity_check)
    end
  end

  def test_sanity_check_option60
    decline = @decline.dup
    decline.option60 = 'test'
    assert_raises Lib::DHCP::SanityCheck::Decline do
      decline.send(:sanity_check)
    end
  end

  def test_sanity_check_option55
    decline = @decline.dup
    decline.option55 = [1,2,3]
    assert_raises Lib::DHCP::SanityCheck::Decline  do
      decline.send(:sanity_check)
    end
  end

  def test_sanity_check_option50
    decline = @decline.dup
    decline.options.del(50)
    assert_raises Lib::DHCP::SanityCheck::Decline do
      decline.send(:sanity_check)
    end
  end

  def test_sanity_check_option54
    decline = @decline.dup
    decline.options.del(54)
    assert_raises Lib::DHCP::SanityCheck::Decline do
      decline.send(:sanity_check)
    end
  end

  def test_pack
    packed = Lib::BOOTP::Packet.new(op:1 , chaddr: '00:11:22:33:44:55', xid: @decline.xid).pack
    packed += [0x63825363.to_i].pack('N')
    packed += [53,1,4].pack('C3')
    packed += [50,4,167772161].pack('C2N')
    packed += [54,4,167772162].pack('C2N')
    packed += [255].pack('C')
    (1..48).each do
      packed += [0].pack('C')
    end
    assert_equal packed, @decline.pack
  end

end