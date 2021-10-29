require_relative "lib/tsne/version"

Gem::Specification.new do |spec|
  spec.name          = "tsne"
  spec.version       = TSNE::VERSION
  spec.summary       = "High performance t-SNE for Ruby"
  spec.homepage      = "https://github.com/ankane/tsne-ruby"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@chartkick.com"

  spec.files         = Dir["*.{md,txt}", "{lib,vendor}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.4"

  spec.add_dependency "numo-narray"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", ">= 5"
end
