
set :stage, :production
set :server_name, "10.230.3.181"

set :server_domain_name, "api-commission.wuliusys.com"
set :node_count, 8

set :repo_url, 'git@git.rfdoa.cn:java/git-api.git'

set :branch, "master"
set :deploy_to, "/data/www/gis-api"

set :god_pid, "#{shared_path}/tmp/pids/god.pid"

server fetch(:server_name), user: "deploy", roles: %w{web app db}
