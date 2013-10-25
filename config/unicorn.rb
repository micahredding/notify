root = "/home/deployer/apps/notify/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.notify.sock"
worker_processes 2
timeout 30
preload_app true

before_fork do |server, worker|
# Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

# If you are using Redis but not Resque, change this
#  if defined?(Resque)
#    Resque.redis.quit
#    Rails.logger.info('Disconnected from Redis')
#  end

# Quit the old unicorn process
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  sleep 1
end

after_fork do |server, worker|
# Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

# If you are using Redis but not Resque, change this
#  if defined?(Resque)
#    Resque.redis = ENV['REDIS_URI']
#    Rails.logger.info('Connected to Redis')
#  end
end
