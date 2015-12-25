set :stage, :production
set :server_name, "10.3.47.62"

set :server_domain_name, "api-commission.wltest.com"
set :node_count, 8

set :repo_url, 'git@git.rfdoa.cn:java/price.git'
set :branch, "dev"
set :deploy_to, "/data/www/gis-api"

set :god_pid, "#{shared_path}/tmp/pids/god.pid"

server fetch(:server_name), user: "deploy", roles: %w{web app db}

