require "json"

require 'simplecov'
require 'simplecov-rcov'
require 'webmock/rspec'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start do
  add_group "Apis", "app/apis"
  add_group "Models", "app/models"
  add_group "Helpers", "app/helpers"
  add_group "Entities", "app/entities"
  add_group "Lib", "lib"

  %w{/spec /script}.each do |dir|
    add_filter dir
  end
end

ENV["G2_ENV"] = "test"

require File.expand_path('../../config/application', __FILE__)

Dir[G2.config.root_dir + "/spec/support/**/*.rb"].each{|f| require f }

# WebMock.disable_net_connect!(:allow_localhost => true)
WebMock.allow_net_connect!

RSpec.configure do |config|
  config.order = "random"
end
