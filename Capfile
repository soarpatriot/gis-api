# Load DSL and Setup Up Stages
require "capistrano/setup"

# Includes default deployment tasks
require "capistrano/deploy"

require "capistrano/rvm"
require "capistrano/bundler"

I18n.enforce_available_locales = true

require 'erb'

def from_template file
  tmp_file = "/tmp/#{file}.tmp"
  info "Generating from 'config/deploy/templates/#{file}' to '#{tmp_file}'"
  template = File.read "config/deploy/templates/#{file}"
  result = ERB.new(template).result self.send(:binding)
  File.open(tmp_file, "w"){|f| f.write result }
  tmp_file
end

# Loads custom tasks from `lib/capistrano/tasks" if you have any defined.
Dir.glob("lib/capistrano/tasks/*.cap").each { |r| import r }
