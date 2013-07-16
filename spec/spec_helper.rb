require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end

  require 'rspec'

  $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
  require 'inline_encryption'
end

Spork.each_run do

end