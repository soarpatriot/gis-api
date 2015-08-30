# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec , cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/apis/(.+)\.rb$})     { |m| "spec/apis/#{m[1]}_spec.rb" }
  watch(%r{^app/models/(.+)\.rb$})   { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^app/helpers/(.+)\.rb$})  { |m| "spec/helpers/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})          { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')       { "spec" }
end
