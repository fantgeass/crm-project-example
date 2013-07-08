require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :application, "Spbec"
set :scm, :git
set :repository,  "git@bitbucket.org:fantgeass/spbec-rails.git"
set :branch, "master"
set :use_sudo, false
set :deploy_via, :remote_cache

default_run_options[:pty] = true
ssh_options[:forward_agent] = true


after 'deploy', 'deploy:cleanup'  # keep only the last 5 releases
after 'deploy:update_code', 'deploy:migrate'
after 'deploy:finalize_update', 'deploy:symlink_db'
#before 'deploy', 'rvm:install_rvm'  # update RVM
#before 'deploy', 'rvm:install_ruby' # install Ruby and create gemset (both if missing)
set :rvm_ruby_string, :local
require 'rvm/capistrano'


namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { no_release: true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
   desc "Symlinks the database.yml"
   task :symlink_db, roles: :app do
     puts 'SYMLINK DB EXECUTED'
     run "ln -nfs #{release_path}/config/database.yml.staging #{release_path}/config/database.yml"
   end
end

namespace :sake do
  desc "Run a task on a remote server."
  # run like: cap staging rake:invoke task=a_certain_task
  task :invoke do
    run("cd #{deploy_to}/current && bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}")
  end
end