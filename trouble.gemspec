require File.expand_path('../lib/trouble/version', __FILE__)

Gem::Specification.new do |spec|

  spec.authors      = %w{ bukowskis }
  spec.summary      = "A generic abstraction layer for reporting errors and Exceptions."
  spec.description  = "This gem achieves independence of things like Bugsnag, Airbrake, etc.. If any of those is defined, Trouble will pass on the exception to them."
  spec.homepage     = 'https://github.com/bukowskis/trouble'
  spec.license      = 'MIT'

  spec.name         = 'trouble'
  spec.version      = Trouble::VERSION::STRING

  spec.files        = Dir['{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  spec.require_path = 'lib'

  spec.rdoc_options.concat ['--encoding',  'UTF-8']

  spec.add_development_dependency('rspec')
  spec.add_development_dependency('guard-rspec')
  spec.add_development_dependency('rb-fsevent')

end
