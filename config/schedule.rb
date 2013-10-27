job_type :sidekiq, "cd :path && RAILS_ENV=:environment bundle exec sidekiq-client :task :output"

every 5.minutes do
  sidekiq "push MailCheckSchedulerWorker"
end