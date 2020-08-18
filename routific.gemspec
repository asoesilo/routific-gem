Gem::Specification.new do |s|
  s.name              = 'routific'
  s.version           = '1.7.3'
  s.date              = '2019-11-26'
  s.add_runtime_dependency('rest-client', '~> 2.0.1')
  s.add_runtime_dependency('json', '~> 2.3.0')
  s.add_development_dependency('rspec', '~> 3.0')
  s.add_development_dependency('faker', '>= 1.6.2')
  s.add_development_dependency('dotenv', '~> 0.11')
  s.summary           = 'routific API'
  s.description       = 'Gem to use Routific API'
  s.email             = 'support@routific.com'
  s.authors           = ["Routific"]
  s.files             = %w(README.md) + Dir["lib/**/*"]
  s.homepage          = 'https://routific.com/'
  s.license           = 'MIT'
  s.metadata    = { "source_code" => "https://github.com/routific/routific-gem" }
end
