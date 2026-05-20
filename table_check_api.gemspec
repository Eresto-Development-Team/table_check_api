$:.push File.expand_path("lib", __dir__)

require "table_check_api/version"

Gem::Specification.new do |spec|
  spec.name        = "table_check_api"
  spec.version     = TableCheckApi::VERSION
  spec.authors     = ["Developer [at] Eresto"]
  spec.email       = ["developer@eresto.co.id"]
  spec.homepage    = "https://github.com/Eresto-Development-Team/table_check_api"
  spec.summary     = "TableCheck API wrapper for Ruby"
  spec.description = "TableCheck API wrapper for Ruby"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'httparty', '~> 0.16', '< 0.21.0'

  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
end