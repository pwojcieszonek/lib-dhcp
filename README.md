# Lib::Dhcp

Ruby library to low level handle the DHCP protocol.

Lib::Dhcp provides tools for constructing, parsing, and manipulating DHCP packets, enabling developers to interact with
the DHCP protocol directly.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lib-dhcp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lib-dhcp

## Usage

Below are some examples of how to use the `lib-dhcp` library:

### Creating a DHCP Packet

You can create a new DHCP Discovery packet:

```ruby
require 'lib/dhcp'

# Create a new DHCP Discovery message
packet = Lib::DHCP::Message::Discover.new

# Print the generated packet
puts packet.to_s
```

### Parsing an Incoming DHCP Packet

To parse a binary DHCP packet:

```ruby
require 'lib/dhcp'

# Binary data representing a DHCP packet
data = "\x01\x01\x06\x00\x8D\x9E2\xA4\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00.\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00.\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00c\x82Sc5\x01" \
  "\x01\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" \
  "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"

# Parse the binary data into a Lib::DHCP::Message
packet = Lib::DHCP::Message.unpack(data)

# Access packet fields and options
puts "Transaction ID: #{packet.xid}"
puts "DHCP Message Type: #{packet.option53}"
```

### Working with DHCP Options

You can manipulate DHCP options easily:

```ruby
require 'lib/dhcp'

packet = Lib::DHCP::Message::Request.new

# Add options
packet.options.add([51, 3600]) # Lease Time
packet.options.add([1, '255.255.255.0']) # Subnet mask
packet.option3 = '192.168.1.1' # Router (Gateway)

# Retrieve an option
lease_time = packet.option51 # Returns the lease time
puts "Lease Time: #{lease_time}s"
```

### Reading DHCP Data from a UDP Socket

You can listen for DHCP packets on a UDP socket:

```ruby
require 'socket'
require 'lib/dhcp'

# Open UDP socket to listen on port 67 (DHCP Server Port)
socket = UDPSocket.new
socket.bind('0.0.0.0', 67)

puts "Listening for DHCP packets on port 67..."

loop do
  # Receive data from the socket
  data, _addr = socket.recvfrom(1024)

  # Parse the received data
  packet = Lib::DHCP::Message.unpack(data)

  # Print information about the packet
  puts "Received DHCP Packet:"
  puts "Transaction ID: #{packet.xid}"
  puts "Client IP: #{packet.ciaddr}"
  puts "Your IP: #{packet.yiaddr}"
  puts "DHCP Message Type: #{packet.options[53]}"
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pwojcieszonek/lib-dhcp. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lib::Dhcp project’s codebases, issue trackers, chat rooms and mailing lists is expected to
follow the [code of conduct](https://github.com/pwojcieszonek/lib-dhcp/blob/master/CODE_OF_CONDUCT.md).
