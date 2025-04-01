require_relative "lib/tsne/version"

Gem::Specification.new do |spec|
  spec.name          = "tsne"
  spec.version       = TSNE::VERSION
  spec.summary       = "High performance t-SNE for Ruby"
  spec.homepage      = "https://github.com/ankane/tsne-ruby"
  spec.license       = "BSD-3-Clause"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib,vendor}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 3.2"

  spec.add_dependency "fiddle"
  spec.add_dependency "numo-narray"
end
