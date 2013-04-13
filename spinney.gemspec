# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "spinney"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sam Kottler"]
  s.date = "2013-04-13"
  s.email = "shk@redhat.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md", "lib", "Gemfile", "spinney.gemspec", "pkg", "pkg/spinney-0.1.0", "pkg/spinney-0.1.0/lib", "pkg/spinney-0.1.0/Rakefile", "pkg/spinney-0.1.0/README.md", "pkg/spinney-0.1.0.gem", "Rakefile"]
  s.homepage = "http://yoursite.example.com"
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "What this thing does"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_runtime_dependency(%q<net-ssh>, [">= 0"])
      s.add_runtime_dependency(%q<erubis>, [">= 0"])
    else
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<net-ssh>, [">= 0"])
      s.add_dependency(%q<erubis>, [">= 0"])
    end
  else
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<net-ssh>, [">= 0"])
    s.add_dependency(%q<erubis>, [">= 0"])
  end
end
