# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'flick_typing'
set :repo_url, 'git@github.com:suiyujin/flick_typing.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, ENV.fetch('DEPLOY_TO')

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', '.env')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.2.3'
set :rbenv_path, '~/.anyenv/envs/rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

set :bundle_jobs, 4

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :start do
    on roles(:all) do
      execute "cd #{current_path} && (RAILS_ENV=produciton #{fetch(:rbenv_prefix)} bundle exec rake unicorn:start)"
    end
  end

  task :stop do
    on roles(:all) do
      execute "cd #{current_path} && (RAILS_ENV=produciton #{fetch(:rbenv_prefix)} bundle exec rake unicorn:stop)"
    end
  end

  task :restart, :clear_cache do
    on roles(:all) do
      execute "cd #{current_path} && (RAILS_ENV=produciton #{fetch(:rbenv_prefix)} bundle exec rake unicorn:stop)"
      execute "cd #{current_path} && (RAILS_ENV=produciton #{fetch(:rbenv_prefix)} bundle exec rake unicorn:start)"
    end
  end
end
