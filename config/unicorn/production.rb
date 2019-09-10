# -*- coding: utf-8 -*-
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 600

preload_app true

app_path = '/var/www/sample-test/current'
working_directory "#{app_path}"

unicorn_backlog = ENV["UNICORN_BACKLOG"] || 2048

listen "/var/www/sample-test/shared/tmp/sockets/unicorn.sock", :backlog =>  Integer(unicorn_backlog)
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
    puts 'Unicorn workers intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end
