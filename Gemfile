source "http://ruby.taobao.org"

gem "i18n"
gem "rest-client", "~> 1.6.7"
gem 'httparty'
gem 'grape'
gem 'grape-entity', "~> 0.4.8"
gem 'grape-kaminari'
gem 'grape-swagger'
gem 'rack-cors'

gem 'mysql2'

gem 'em-synchrony'
gem 'em-http-request'

gem 'devise'
gem 'gretel'
gem 'acts_as_votable', '~> 0.10.0'
gem 'acts_as_tree'
gem 'settingslogic'

gem 'rpush'
gem 'geocoder'
gem 'god'

gem 'awesome_nested_set'
gem 'uuidtools'
gem 'pry'

gem 'activerecord', '~> 4.1.1'
gem 'actionmailer', '~> 4.1.1'
gem 'bcrypt'
gem 'delete_paranoid'
gem 'mini_magick'
# gem 'carrierwave', :require => %w(carrierwave carrierwave/orm/activerecord)
# gem 'carrierwave-qiniu', github: 'huobazi/carrierwave-qiniu' 

group :production do
  gem 'goliath'
  gem 'em-synchrony'
  gem 'em-http-request'
end



group :development do

  gem 'guard-rspec'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
end

group :test do
  gem 'spreadsheet'
  gem 'factory_girl'
  gem 'rspec'
  gem 'ci_reporter'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'database_cleaner'

  gem 'webmock'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'rack-test', require: 'rack/test'
end
