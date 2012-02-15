# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "massive_sitemap-writer-s3"
  s.version     = File.read("VERSION").to_s.strip
  s.authors     = ["Tobias Bielohlawek"]
  s.email       = ["tobi@soundcloud.com"]
  s.homepage    = "http://github.com/rngtng/massive_sitemap-writer-s3"
  s.summary     = %q{Amazon S3 Writer extension for MassiveSitemap}
  s.description = %q{Amazon S3 Writer extension for MassiveSitemap}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.extra_rdoc_files = [
    "README.md"
  ]

  %w(s3 massive_sitemap retryable).each do |gem|
    s.add_runtime_dependency *gem.split(' ')
  end

  %w(rake rspec).each do |gem|
    s.add_development_dependency *gem.split(' ')
  end
end
