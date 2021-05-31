require_relative "lib/active_record_associations_module_name/version"

Gem::Specification.new do |spec|
  spec.name        = "active_record_associations_module_name"
  spec.version     = ActiveRecordAssociationsModuleName::VERSION
  spec.authors     = ["Rafe Rosen"]
  spec.email       = ["rafe@existentialmutt.com"]
  spec.homepage    = "http://github.com/existentialmutt/active_record_associations_module_name"
  spec.summary     = "Provides a `module_name` option for ActiveRecord Associations"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "http://github.com/existentialmutt/active_record_associations_module_name/releases"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "activerecord", ">= 5.2", "< 7"
  spec.add_development_dependency "rails", ">= 5.2", "< 7"
end
