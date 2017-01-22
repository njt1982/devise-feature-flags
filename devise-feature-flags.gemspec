# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise/feature_flags/version'

Gem::Specification.new do |spec|
  spec.name          = "devise-feature-flags"
  spec.version       = Devise::FeatureFlags::VERSION
  spec.authors       = ["Nicholas Thompson"]
  spec.email         = ["njt1982@gmail.com"]

  spec.summary       = %q{Devise FeatureFlags provides a feature flagging for your site's users}
  spec.description   = %q{Include only specific users in your sites new features.}
  spec.homepage      = "https://github.com/njt1982/devise-feature-flags"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'rails', '~> 4.2'
  spec.add_dependency 'devise', '~> 3.4'
end
