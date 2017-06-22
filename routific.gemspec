Gem::Specification.new do |s|
  s.name              = 'routific'
  s.version           = '1.1.1'
  s.date              = '2016-08-12'
  s.add_runtime_dependency('rest-client', '~> 1.7')
  s.add_runtime_dependency('json', '~> 1.8')
  s.add_development_dependency('rspec', '~> 3.0')
  s.add_development_dependency('faker', '~> 1.4')
  s.add_development_dependency('vcr')
  s.add_development_dependency('webmock')
  s.add_development_dependency('dotenv', '~> 0.11')
  s.summary           = 'routific API'
  s.description       = 'Gem to use Routific API'
  s.authors           = ['Marc Kuo', 'Andre Soesilo']
  s.email             = 'asoesilo@live.com'
  s.files             = %w(README.md) + Dir["lib/**/*"]
  s.homepage          = 'https://routific.com/'
  s.license           = 'MIT'
  s.metadata    = { "source_code" => "https://github.com/asoesilo/routific-gem" }
end
