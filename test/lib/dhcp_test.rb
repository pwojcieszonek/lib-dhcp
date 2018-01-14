require_relative '../test_helper'

class Lib::DHCPTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Lib::DHCP::VERSION
  end

end
