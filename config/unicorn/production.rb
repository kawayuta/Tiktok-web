# -*- coding: utf-8 -*-
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 10)
timeout 30

preload_app true

app_path = '/var/www/sample-test/current'
working_directory "#{app_path}"

listen "/var/www/sample-test/shared/tmp/sockets/unicorn.sock"
pid "/var/www/sample-test/shared/tmp/pids/unicorn.pid"

stdout_path "#{app_path}/log/unicorn.log"
stderr_path "#{app_path}/log/unicorn.log"

stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end
