
set :stage, :production
set :server_name, "api.cityhub.me"
set :branch, "dev"
set :node_count, 2
set :server_domain_name, "api.cityhub.me"

set :deploy_to, "/data/www/gis-api"

set :god_pid, "#{shared_path}/tmp/pids/god.pid"

server fetch(:server_name), user: "soar", roles: %w{web app db}
