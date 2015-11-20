lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sql_trace/version'

Gem::Specification.new do |spec|
  spec.name     = 'sql_trace'
  spec.version  = SqlTrace::VERSION
  spec.authors  = ['Karol Słuszniak']
  spec.email    = 'karol@cloudless.pl'
  spec.homepage = 'http://github.com/karolsluszniak/sql-trace'
  spec.license  = 'MIT'
  spec.platform = Gem::Platform::RUBY

  spec.summary = 'Trace ActiveRecord calls in development console'
  spec.description = spec.summary

  spec.files            = Dir["lib/**/*.rb"]
  spec.has_rdoc         = false
  spec.extra_rdoc_files = ["README.md"]
  spec.test_files       = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths    = ["lib"]

  spec.add_development_dependency 'colorize'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'activesupport'
end
