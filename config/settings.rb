
class Settings < Settingslogic
  source "#{G2.config.root_dir}/config/application.yml"
  namespace ENV["G2_ENV"] || "development"
end