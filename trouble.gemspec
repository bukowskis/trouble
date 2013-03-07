Gem::Specification.new do |spec|

  spec.name        = 'trouble'
  spec.version     = '0.0.1'
  spec.date        = '2013-03-07'
  spec.summary     = "A generic abstraction layer for reporting errors"
  spec.description = "See https://github.com/bukowskis/trouble"
  spec.authors     = %w{ bukowskis }
  spec.homepage    = 'https://github.com/bukowskis/trouble'

  spec.files       = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")

  spec.add_dependency('bugsnag')

  spec.add_development_dependency('rspec')
  spec.add_development_dependency('guard-rspec')
  spec.add_development_dependency('rb-fsevent')

end
