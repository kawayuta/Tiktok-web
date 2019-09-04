# 共通の設定をconfig/deploy.rbで記述

# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

# 基本設定
set :application, "sample-test"
set :repo_url,    "git@github.com:kawayuta/sample-test.git"
set :user,        'kawayuta'

set :deploy_to, '/var/www/sample-test'

set :rbenv_type, :user
set :rbenv_ruby, '2.6.2'
set :rbenv_path, '/home/kawayuta/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

set :keep_releases, 5
set :deploy_via, :remote_cache

set :log_level, :debug
set :pty, false

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs,  %w{bin log tmp/pids tmp/sockets tmp/cache vender/bundle}

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :mkdir, '-p', release_path.join('tmp')
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  task :task_tag_update do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'task_database:get_tag_data'
        end
      end
    end
  end

  task :task_input_trending do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'task_database:get_trending'
        end
      end
    end
  end

  task :task_input_video_from_tag do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'task_database:get_video_from_tag'
        end
      end
    end
  end

  task :task_upload_youtube do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'task_database:upload_youtube'
        end
      end
    end
  end


  task :migrate_rest do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'RAILS_ENV=production db:migrate:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
        end
      end
    end
  end

  task :sidekiq_start do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'bundle exec sidekiq --environment production --daemon'
        end
      end
    end
  end

  desc 'upload important files'
  task :upload do
    on roles(:app) do |host|
      execute :mkdir, '-p', "#{shared_path}/config"
      upload!('config/database.yml',"#{shared_path}/config/database.yml")
      upload!('config/secrets.yml',"#{shared_path}/config/secrets.yml")
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do

      within release_path do
        execute :rm, '-rf', release_path.join('tmp/cache')
      end
    end
  end

  before :started,   'deploy:upload'
  after  :finishing, 'deploy:cleanup'
  after  :finishing, 'deploy:sidekiq_start'

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end
