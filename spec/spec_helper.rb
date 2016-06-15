require 'rubygems'

require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'rspec'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'inline_encryption'
