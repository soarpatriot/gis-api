
set :stage, :production
set :server_name, "api.dreamreality.cn"

set :branch, "master"
set :deploy_to, "/data/www/dream"

set :god_pid, "#{shared_path}/tmp/pids/god.pid"

server fetch(:server_name), user: "soar", roles: %w{web app db}
