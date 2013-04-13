require "rubygems"
require "rubygems/package_task"
require "rdoc/task"

task :default => :package do
  puts "Don't forget to write some tests!"
end

spec = Gem::Specification.new do |s|
  s.name              = "spinney"
  s.version           = "0.1.0"
  s.summary           = "What this thing does"
  s.author            = "Sam Kottler"
  s.email             = "shk@redhat.com"
  s.homepage          = "http://yoursite.example.com"

  s.has_rdoc          = true
  s.extra_rdoc_files  = %w(README.md)
  s.rdoc_options      = %w(--main README.md)

  s.files             = %w(README.md) + Dir.glob("**/*")
  s.require_paths = ["lib"]

  s.add_development_dependency("mocha")
  s.add_development_dependency("bundler")
  s.add_development_dependency("rake")
  s.add_development_dependency("rdoc")

  s.add_dependency("net-ssh")
  s.add_dependency("erubis")
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end

task :package => :gemspec
RDoc::Task.new do |rd|
  rd.main = "README.md"
  rd.rdoc_files.include("README.md", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
  rm "#{spec.name}.gemspec"
end
