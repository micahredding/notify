class MailCheckScheduler

  def initialize
  end

  def schedule_checks
    fetch_overdue_gmail_accounts
    schedule_workers
  end

  private

  def fetch_overdue_gmail_accounts
    @gmail_accounts = GmailAccount.overdue
  end

  def schedule_workers
    @gmail_accounts.find_in_batches do |batch|
      batch.each do |gmail_account|
        MailCheckWorker.perform_async(gmail_account.id)
      end
    end
  end

end