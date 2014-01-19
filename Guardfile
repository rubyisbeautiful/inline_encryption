# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', all_after_pass: true, failed_mode: :focus, all_on_start: true, cmd: 'rspec spec --drb --debugger' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}){ |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb'){ "spec" }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
end

guard 'spork', :test_unit => false do
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
end

