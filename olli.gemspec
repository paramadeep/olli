Gem::Specification.new do |s|
  s.name        = 'olli'
  s.version     = '0.0.1'
  s.date        = '2015-06-06'
  s.summary     = 'slim page-objects'
  s.description = "slim page-objects for UI tests"
  s.authors     = ["Deepak"]
  s.files       = Dir['README.md', 'lib/**/*']
  s.test_files  = Dir['spec/**/*']
  s.homepage    = 'https://github.com/paramadeep/olli'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec', '3.0.0'
  s.add_development_dependency 'rake','10.3.2'
  s.add_development_dependency 'capybara','2.4.1'
  s.add_development_dependency 'pry','0.10.0'
  s.add_development_dependency 'rubygems-tasks', '0.2.4'
  s.add_development_dependency 'simplecov', '0.9.0'
  s.add_runtime_dependency 'pageify'
end
