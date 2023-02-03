require "bundler/gem_tasks"
require "rake/testtask"

task default: :test
Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.warning = false
end

def download_file(file)
  require "open-uri"

  url = "https://github.com/ankane/ml-builds/releases/download/multicore-tsne-master/#{file}"
  puts "Downloading #{file}..."
  dest = "vendor/#{file}"
  File.binwrite(dest, URI.parse(url).read)
  puts "Saved #{dest}"
end

namespace :vendor do
  task :linux do
    download_file("libtsne_multicore.so")
  end

  task :mac do
    download_file("libtsne_multicore.dylib")
  end

  task :windows do
    download_file("tsne_multicore.dll")
  end

  task all: [:linux, :mac, :windows]
end
