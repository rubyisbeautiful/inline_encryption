# frozen_string_literal: true

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', all_after_pass: true, failed_mode: :focus, all_on_start: true, cmd: 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { 'spec' }
  watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }
end
