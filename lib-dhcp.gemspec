
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lib/dhcp/version'

Gem::Specification.new do |spec|
  spec.name          = 'lib-dhcp'
  spec.version       = Lib::DHCP::VERSION
  spec.authors       = ['Piotr Wojcieszonek']
  spec.email         = ['piotr@wojcieszonek.pl']

  spec.summary       = %q{DHCP protocol library.}
  spec.description   = %q{Set of classes to low level handle the BOOTP protocol.}
  spec.homepage      = 'https://github.com/pwojcieszonek/lib-dhcp'
  spec.license       = 'MIT'


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.add_dependency 'lib-bootp', '~> 0.1'
  spec.add_dependency 'net-address', '~> 0.1'
end
