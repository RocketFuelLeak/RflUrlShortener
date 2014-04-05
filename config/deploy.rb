lock '3.1.0'

set :application, 'RflUrlShortener'
set :repo_url, 'git@github.com:RocketFuelLeak/RflUrlShortener.git'
set :deploy_to, "/home/#{fetch(:user, 'rails')}/apps/#{fetch(:application)}"
set :log_level, :info
set :linked_files, %w{config/database.yml config/secrets.yml}
set :ssh_options, { forward_agent: true }

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  before :deploy, :check_revision do
    on roles(:web) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc "Setup the base config files"
  task :setup_configs do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! "config/database.example.yml", "#{shared_path}/config/database.yml"
      upload! "config/secrets.example.yml", "#{shared_path}/config/secrets.yml"
      puts "Now edit the config files in #{shared_path}."
      puts "Execute the following commands:"
      puts "sudo ln -nfs #{current_path}/config/nginx_#{rails_env}.conf /etc/nginx/sites-enabled/#{application}_#{rails_env}"
      puts "sudo ln -nfs #{current_path}/config/unicorn_init_#{rails_env}.sh /etc/init.d/unicorn_#{application}_#{rails_env}"
      puts "sudo update-rc.d -f unicorn_#{application}_#{rails_env} defaults"
    end
  end

  %w{start stop restart}.each do |command|
    desc "#{command} application"
    task command do
      on roles(:app), in: :sequence, wait: 5 do
        execute "/etc/init.d/unicorn_#{fetch(:application)}_#{fetch(:stage)}", command
      end
    end
  end

  after :publishing, :restart
end

namespace :nginx do
  desc "Reload nginx configs"
  task :reload do
    on roles(:web) do
      sudo 'service nginx reload'
    end
  end

  desc "Restart nginx server"
  task :restart do
    on roles(:web) do
      execute :sudo, :service, :nginx, :restart
    end
  end
end
