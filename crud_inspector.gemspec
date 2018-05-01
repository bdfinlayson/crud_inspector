$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "crud_inspector/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "crud_inspector"
  s.version     = CrudInspector::VERSION
  s.authors     = ["Bryan Finlayson"]
  s.email       = ["bryan.finlayson@metova.com"]
  s.homepage    = "https://github.com/bdfinlayson/crud_inspector"
  s.summary     = "Keeps a record of recent CRUD transactions by REST or SOAP protocol"
  s.description = "Keeps a record of recent CRUD transactions by REST or SOAP protocol"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.1"

  s.add_development_dependency "sqlite3"
end
