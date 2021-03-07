version = File.read(File.expand_path('../VERSION', __FILE__)).strip

Gem::Specification.new do |spec|
  spec.name          = 'jsonapi-ruby-deserializer'
  spec.version       = version
  spec.author        = 'Grzegorz Płóciniak'
  spec.email         = 'grzegorzsend@gmail.com'
  spec.summary       = 'JSON API Ruby deserializer'
  spec.description   = 'Makes work with JSON::API compound documents easy'
  spec.homepage      = 'https://github.com/igatto/jsonapi-ruby-deserializer'
  spec.license       = 'MIT'

  spec.files         = Dir['README.md', 'lib/**/*']
  spec.require_path  = 'lib'

  spec.add_development_dependency 'rake', '>=0.9'
  spec.add_development_dependency 'rspec', '~>3.5'
end
