set :deploy_to, "/home/spbec"
set :user, "root"
server "172.22.38.88", :db, :app, :web, primary: true