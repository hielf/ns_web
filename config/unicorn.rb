rails_env = ENV['RAILS_ENV'] || 'production'
worker_processes 2
root = "/home/webmaster/ns_web/"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.stderr.log"
stdout_path "#{root}/log/unicorn.stdout.log"

listen "/home/webmaster/ns_web/tmp/unicorn.sock", :backlog => 64

timeout 30

before_fork do |server, worker|
# This option works in together with preload_app true setting
# What is does is prevent the master process from holding
# the database connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end
 
after_fork do |server, worker|
# Here we are establishing the connection after forking worker
# processes
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end