class MailCheckSchedulerWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 3

  def perform
    MailCheckScheduler.new.schedule_checks
  end
end