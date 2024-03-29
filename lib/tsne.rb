# dependencies
require "numo/narray"

# stdlib
require "fiddle/import"

# modules
require_relative "tsne/model"
require_relative "tsne/version"

module TSNE
  class Error < StandardError; end

  class << self
    attr_accessor :ffi_lib
  end
  lib_name =
    if Gem.win_platform?
      "tsne_multicore.dll"
    elsif RbConfig::CONFIG["host_os"] =~ /darwin/i
      if RbConfig::CONFIG["host_cpu"] =~ /arm|aarch64/i
        "libtsne_multicore.arm64.dylib"
      else
        "libtsne_multicore.dylib"
      end
    else
      if RbConfig::CONFIG["host_cpu"] =~ /arm|aarch64/i
        "libtsne_multicore.arm64.so"
      else
        "libtsne_multicore.so"
      end
    end
  vendor_lib = File.expand_path("../vendor/#{lib_name}", __dir__)
  self.ffi_lib = [vendor_lib]

  # friendlier error message
  autoload :FFI, "tsne/ffi"

  def self.new(*args, **options)
    Model.new(*args, **options)
  end
end
