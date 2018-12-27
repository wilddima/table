lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'table'
  spec.version = '0.0.1'
  spec.summary = 'summary'
  spec.author = 'wild_dima'
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rspec'
end
