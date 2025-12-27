require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end

task default: :test

def download_file(file, sha256)
  require "open-uri"

  url = "https://github.com/ankane/ml-builds/releases/download/multicore-tsne-master/#{file}"
  puts "Downloading #{file}..."
  contents = URI.parse(url).read

  computed_sha256 = Digest::SHA256.hexdigest(contents)
  raise "Bad hash: #{computed_sha256}" if computed_sha256 != sha256

  dest = "vendor/#{file.sub(".openmp", "")}"
  File.binwrite(dest, contents)
  puts "Saved #{dest}"
end

namespace :vendor do
  task :linux do
    download_file("libtsne_multicore.so", "bf06bf8aa40968536173a1838778044e8169ae96fa3b528a6c81711e287dce9a")
    download_file("libtsne_multicore.arm64.so", "3322403096fa200b71a4add675ddb8060f017508c4f379c1dfe9f6885f24f295")
  end

  task :mac do
    download_file("libtsne_multicore.openmp.dylib", "27780a50c5a8a9117e1f8b64e8d166acd6422319753c8f60e00c4c01d49c5aff")
    download_file("libtsne_multicore.arm64.openmp.dylib", "6503b8d3c8da2306c79334f7e0cb1884640ba65b66585bac6c3d904880bb2752")
  end

  task :windows do
    download_file("tsne_multicore.dll", "95d8a91c1a7aeb61f08b7974729bbb36d531216584cb3d310be656850aff633b")
  end

  task all: [:linux, :mac, :windows]

  task :platform do
    if Gem.win_platform?
      Rake::Task["vendor:windows"].invoke
    elsif RbConfig::CONFIG["host_os"] =~ /darwin/i
      Rake::Task["vendor:mac"].invoke
    else
      Rake::Task["vendor:linux"].invoke
    end
  end
end
