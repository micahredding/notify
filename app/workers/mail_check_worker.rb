class MailCheckWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 3

  def perform(gmail_account_id)
    MailChecker.new(gmail_account_id).check
  end
end