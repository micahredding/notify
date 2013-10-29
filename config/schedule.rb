job_type :sidekiq, "cd :path && RAILS_ENV=:environment bundle exec sidekiq-client :task :output"

every 10.minutes do
  sidekiq "push MailCheckSchedulerWorker"
end