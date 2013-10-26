class MailChecker

  def initialize gmail_account_id
    @gmail_account_id = gmail_account_id
  end

  def check
    refresh_access_tokens
    get_gmail_account
    get_emails
    save_emails_and_notifications
  end

  private

  def refresh_access_tokens
    TokenRefresher.new(gmail_account_id).refresh
  end

  def get_gmail_account
    @gmail_account = GmailAccount.find(@gmail_account_id)
  end

  def get_emails
    @emails = EmailsFetcher.new(@gmail_account).fetch
  end

end