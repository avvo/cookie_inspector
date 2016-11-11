$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cookie_inspector/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cookie_inspector"
  s.version     = CookieInspector::VERSION
  s.authors     = ["Jake Sparling"]
  s.email       = ["jsparling@avvo.com"]
  s.homepage    = ""
  s.summary     = "Provides helpers to display cookie information for debugging."
  s.description = "Helpers and partials to display cookie contents, even for encrypted cookies. Not meant for production" 
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "> 4.2"
end
