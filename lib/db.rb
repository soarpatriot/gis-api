require "mysql2"

require "logger"
require "em-synchrony/activerecord"

case G2.env
when "production"
  logger = Logger.new("log/production.log")
  logger.level = Logger::WARN
when "development"
  logger = Logger.new(STDOUT)
  logger.level = Logger::DEBUG

  logger.formatter = proc do |severity, datetime, progname, msg|
    "#{msg}\n"
  end
else
  logger = Logger.new("/dev/null")
end

ActiveSupport.on_load(:active_record) do
  self.include_root_in_json = false
  self.default_timezone = :local
  self.time_zone_aware_attributes = false
  self.logger = logger
end

db_config = YAML.load_file(G2.config.config_dir + '/database.yml')
ActiveRecord::Base.establish_connection(db_config[G2.env.to_s])
