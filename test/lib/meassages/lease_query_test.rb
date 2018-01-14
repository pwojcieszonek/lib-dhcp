#Author: Piotr Wojcieszonek
#e-mail: piotr@wojcieszonek.pl
# Copyright 25.03.2016 by Piotr Wojcieszonek


require_relative '../../test_helper'

class LeaseQuery < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @lease_query = Lib::DHCP::Message::LeaseQuery.new(chaddr: '00:11:22:33:44:55')
  end

  def test_op_code
    assert_equal 1, @lease_query.op.to_i
  end

  def test_message_type
    assert_equal 10, @lease_query.option53.to_i
  end

  def test_pack
    packed = Lib::BOOTP::Packet.new(op:1 , chaddr: '00:11:22:33:44:55', xid: @lease_query.xid).pack
    packed += [0x63825363.to_i].pack('N')
    packed += [53,1,10].pack('C3')
    packed += [255].pack('C')
    (1..60).each do
      packed += [0].pack('C')
    end
    assert_equal packed, @lease_query.pack
  end

end