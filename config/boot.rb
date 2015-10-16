require "rubygems"
require "bundler/setup"

Bundler.require :default

root_dir = File.expand_path("../..", __FILE__)
app_dir = File.join(root_dir, "app")

$LOAD_PATH.unshift root_dir
$LOAD_PATH.unshift app_dir

%w{apis helpers mailers models entities uploaders}.each do |dir|
  $LOAD_PATH.unshift File.join(app_dir, dir)
end
%w{config lib}.each do |dir|
  $LOAD_PATH.unshift File.join(root_dir, dir)
end
$LOAD_PATH.unshift File.join(root_dir, "config/initializers")


require 'g2'
require 'db'

require 'v1'
require 'v2'
require 'settings'




# load own i18ns
I18n.load_path += Dir[File.join(G2.config.root_dir, 'config', 'locales', '*.{rb,yml}')]

# loading initializers
Dir.glob("config/initializers/*.rb").each do |initializer|
  require initializer
end


Dir.glob('app/uploaders/**/*.rb').each do |item|
  require item
end


Dir.glob('app/models/**/*.rb').each do |item|
  require item
end

Dir.glob('app/helpers/**/*.rb').each do |item|
  require item
end

Dir.glob('app/entities/**/*.rb').each do |item|
  require item
end

Dir.glob('app/apis/**/*.rb').each do |item|
  require item
end











