# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'katagami/version'

Gem::Specification.new do |spec|
  spec.name          = "katagami"
  spec.version       = Katagami::VERSION
  spec.authors       = ["Shu Fujita"]
  spec.email         = ["osorubeki.fujita@gmail.com"]

  spec.summary       = "This gem enable you to search and copy file of Ise-kagami image files privided by the book specified by 'http://www.amazon.co.jp/dp/4756243304/'."
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/osorubeki-fujita/katagami"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
    # raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "active_support"
  spec.add_runtime_dependency "positive_basic_support"
  spec.add_runtime_dependency "positive_number_support"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_development_dependency "capistrano"
  spec.add_development_dependency "deplo", ">= 0.2.0"
end
