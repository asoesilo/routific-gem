Gem::Specification.new do |s|
  s.name              = 'routific'
  s.version           = '1.0.1'
  s.date              = '2015-10-26'
  s.add_runtime_dependency('rest-client', '~> 1.7')
  s.add_runtime_dependency('json', '~> 1.8')
  s.add_development_dependency('rake')
  s.add_development_dependency('pry')
  s.add_development_dependency('rspec', '~> 3.0')
  s.add_development_dependency('faker', '~> 1.4')
  s.add_development_dependency('dotenv', '~> 0.11')
  s.add_development_dependency('webmock', '~> 1.22')
  s.summary           = 'routific API'
  s.description       = 'Gem to use Routific API'
  s.authors           = ['Marc Kuo', 'Andre Soesilo']
  s.email             = 'asoesilo@live.com'
  s.files             = ['./lib/routific.rb', './lib/routific/location.rb',
                          './lib/routific/route.rb', './lib/routific/vehicle.rb',
                          './lib/routific/visit.rb', './lib/routific/way_point.rb']
  s.homepage          = 'https://routific.com/'
  s.extra_rdoc_files  = ['README.md']
  s.license           = 'MIT'
  s.metadata    = { "source_code" => "https://github.com/asoesilo/routific-gem" }
end
