$:.push File.expand_path("lib", __dir__)

require "table_check/api/version"

Gem::Specification.new do |spec|
  spec.name        = "tablecheck_api"
  spec.version     = TableCheck::Api::VERSION
  spec.authors     = ["Developer [at] Eresto"]
  spec.email       = ["developer@eresto.co.id"]
  spec.homepage    = "https://github.com/Eresto-Development-Team/tablecheck_api"
  spec.summary     = "Eresto system's tablecheck api module"
  spec.description = "Eresto system's tablecheck api module."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'httparty', '~> 0.16', '< 0.21.0'
end