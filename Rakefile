require "rubygems"
require "bundler/setup"

require 'yaml'

unless ENV["G2_ENV"] == "production"
  require 'rspec/core/rake_task'
  # require 'ci/reporter/rake/rspec'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
  # task :spec => "ci:setup:rspec"
end

task :environment do
  require File.expand_path('../config/application', __FILE__)
end

desc "list api routes"
task :routes => :environment do
  ServiceApplication.routes.each do |route|
    puts "#{route.route_method} \t #{route.route_path}"
  end
end

def db_conf
  YAML.load File.read('config/database.yml')
end

def migration_name migration_name
  separator = "_"
  if migration_name.include?(separator)
    migration_name = migration_name.split(separator).collect { |item| item.capitalize }.join
  else
    migration_name.capitalize
  end
end

desc "using console" 
task :console do
  require_relative "config/application"
  Pry.start
end

namespace :db do
  desc "creates and migrates your database"
  task :setup => :environment do
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
  end

  desc "migrate your database"
  task :migrate => :environment do
    migration_path = ActiveRecord::Migrator.migrations_paths
    version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    ActiveRecord::Migrator.migrate migration_path, version
  end

  desc 'Drops the database'
  task :drop => :environment do
    env = ENV["G2_ENV"] || "development"
    ActiveRecord::Base.connection.drop_database db_conf[env]['database']
    puts "#{db_conf[env]['database']} has been dropped"
  end

  desc 'Creates the database'
  task :create do
    require "active_record"
    
    env = ENV["G2_ENV"] || "development"
    conf = db_conf[env]
    conf.delete "database"
    ActiveRecord::Base.establish_connection conf
    ActiveRecord::Base.connection.create_database db_conf[env]['database']
    puts "#{db_conf[env]['database']} has been created"
  end

  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
  task :rollback => :environment do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Migrator.rollback ActiveRecord::Migrator.migrations_paths, step
  end
end

namespace :g do
  desc "create model as rake g:model name=***"
  task :model do
    migration_name = migration_name ENV["name"]
    timestamp = Time.now.strftime "%Y%m%d%H%M%S"
    output_file_name = "#{timestamp}_create_#{ENV["name"]}s.rb"

    model_file = File.open("./app/models/#{ENV["name"]}.rb", "w")
    model_file.puts "class #{migration_name} < ActiveRecord::Base"
    model_file.puts "end"
    model_file.close

    migration_file = File.open("./db/migrate/#{output_file_name}", "w")
    migration_file.puts "class Create#{migration_name}s < ActiveRecord::Migration"
    migration_file.puts "  def change"
    migration_file.puts "    create_table :#{ENV["name"]}s do |t|"
    migration_file.puts "      t.timestamps"
    migration_file.puts "    end"
    migration_file.puts "  end"
    migration_file.puts "end"
    migration_file.close
  end

  desc "create migration as rake g:migration name=***"
  task :migration do
    migration_name = migration_name ENV["name"]
    timestamp = Time.now.strftime "%Y%m%d%H%M%S"
    output_file_name = "#{timestamp}_#{ENV["name"]}.rb"

    migration_file = File.open("./db/migrate/#{output_file_name}", "w")
    migration_file.puts "class #{migration_name} < ActiveRecord::Migration"
    migration_file.puts "  def change"
    migration_file.puts "  end"
    migration_file.puts "end"
    migration_file.close
  end
end
