
set :stage, :test
set :server_name, "test.tingfangyan.com"

set :branch, "dev"
set :deploy_to, "/data/www/dialect-api"

set :thin_pid, "#{shared_path}/tmp/pids/thin.0.pid"
set :god_pid, "#{shared_path}/tmp/pids/god.pid"

server fetch(:server_name), user: "soar", roles: %w{web app db}
