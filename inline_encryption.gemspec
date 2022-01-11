# frozen_string_literal: true

require 'English'
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inline_encryption/version'

Gem::Specification.new do |spec|
  spec.name          = 'inline_encryption'
  spec.version       = InlineEncryption::VERSION
  spec.authors       = ['rubyisbeautiful']
  spec.email         = 'bcptaylor+github@gmail.com'
  spec.description   = ' A simple encryption tool based on common convention '
  spec.summary       = ' A drop-in simple encryption tool for stringish things '
  spec.homepage      = 'https://github.com/rubyisbeautiful/inline_encryption'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.1.5'

  spec.executables = ['inline_encryption']

  spec.add_runtime_dependency 'hashie'
  spec.add_runtime_dependency 'i18n'
  spec.add_runtime_dependency 'thor'
end
