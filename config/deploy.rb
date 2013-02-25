require 'capistrano_colors'
require "rvm/capistrano" # Rvm bootstrap
require 'bundler/capistrano'

server "5.9.201.157", :app, :web, :db, :primary => true

set :shared_host, "5.9.201.157"
set :application, "knowledgebase"
set :deploy_to,   "/home/devmen/apps/#{application}/"
set :user, "devmen"
set :branch, "master"
set :rvm_ruby_string, "2.0.0@knowledgebase"
set :rails_env, "production"

#default_run_options[:shell] = '/bin/bash'
default_run_options[:pty] = true

set :repository,  "git@github.com:ck3g/knowledgebase.git"
set :scm, :git

set :deploy_via,  :export
set :keep_releases, 5

set :use_sudo, false

set :rvm_type, :user
set :normalize_asset_timestamps, false

after "deploy",                 "deploy:cleanup"
after "deploy:finalize_update", "deploy:config", "deploy:update_uploads"
after "deploy:create_symlink", "deploy:mongoid_indexes"
after "deploy"

def run_remote_rake(rake_cmd)
  rake_args = ENV['RAKE_ARGS'].to_s.split(',')
  cmd = "cd #{fetch(:latest_release)} && #{fetch(:rake, "rake")} RAILS_ENV=#{fetch(:rails_env, "staging")} #{rake_cmd}"
  cmd += "['#{rake_args.join("','")}']" unless rake_args.empty?
  run cmd
  set :rakefile, nil if exists?(:rakefile)
end

CONFIG_FILES = %w(mongoid)

namespace :deploy do
  task :setup_config, :roles => :app do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/system"
    run "mkdir -p #{shared_path}/uploads"
    CONFIG_FILES.each do |file|
      put File.read("config/#{file}.yml"), "#{shared_path}/config/#{file}.yml"
    end
    puts "Now edit the config files in #{shared_path}"
  end
  after "deploy:setup", "deploy:setup_config"

  before "deploy:cold", "deploy:install_bundler"
  task :install_bundler, :roles => :app do
    run "type -P bundle &>/dev/null || { gem install bundler --no-ri --no-rdoc; }"
  end

  task :config do
    CONFIG_FILES.each do |file|
      run "cd #{release_path}/config && ln -nfs #{shared_path}/config/#{file}.yml #{release_path}/config/#{file}.yml"
    end
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :update_uploads, :roles => [:app] do
    run "ln -nfs #{deploy_to}#{shared_dir}/uploads #{release_path}/public/uploads"
    run "ln -nfs #{deploy_to}#{shared_dir}/system #{release_path}/public/system"
  end

  desc "Create MongoDB indexes"
  task :mongoid_indexes do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:mongoid:create_indexes", :once => true
  end
end

desc "Tail production log files"
task :tail_logs, :roles => :app do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    trap ("INT") { puts "\nInterrupded"; exit 0; }
    puts
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end
