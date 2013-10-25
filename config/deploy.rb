require 'bundler/capistrano'
load 'lib/deploy/seed'
require 'sidekiq/capistrano'

server "notify.zapto.org", :web, :app, :db, primary: true

set :application, "notify"
set :user , "deployer"
set :deploy_to , "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache

set :use_sudo, false

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :scm, :git
set :repository, "git@github.com:micahredding/notify.git"
set :branch, "master"

# keep only the last 5 releases
after "deploy", "deploy:cleanup"

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"
#after "deploy", "whenever:update_crontab"

namespace :deploy do
  %w[start stop restart upgrade].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :server_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/application.example.yml"), "#{shared_path}/config/application.yml"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

namespace :rails do
  desc "script/console on a remote server"
  task :console do
    rails_env = fetch(:rails_env, "production")
    server = find_servers(:roles => [:app]).first
    run_with_tty server, %W( ./script/rails console #{rails_env} )
  end

  desc "script/dbconsole on a remote server"
  task :dbconsole do
    rails_env = fetch(:rails_env, "production")
    server = find_servers(:roles => [:app]).first
    run_with_tty server, %W( ./script/rails dbconsole #{rails_env} )
  end

  def run_with_tty server, cmd
    # looks like total pizdets
    command = []
    command += %W( ssh -t #{gateway} -l #{self[:gateway_user] || self[:user]} ) if self[:gateway]
    command += %W( ssh -t )
    command += %W( -p #{server.port}) if server.port
    command += %W( -l #{user} #{server.host} )
    command += %W( cd #{current_path} )
    # have to escape this once if running via double ssh
    command += [self[:gateway] ? '\&\&' : '&&']
    command += Array(cmd)
    system *command
  end
end