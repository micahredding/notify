class EmailsFetcher

  def initialize gmail_account
    @gmail_account = gmail_account
    @rules_checker = RulesChecker.new(@gmail_account)
    @filtered_emails = []
  end

  def fetch
    connect_gmail
    get_emails
    filter_emails
    save_results
  end

  private

  def connect_gmail
    @gmail = Gmail.connect(:xoauth2, @gmail_account.email, @gmail_account.token)
  end

  def get_emails
    @emails = @gmail.inbox.emails(:all, :after => start_date).select { |email| email.uid > start_uid }
  end

  def filter_emails
    @emails.each do |email|
      @filtered_emails << email if @rules_checker.check(email)
    end
  end

  def save_results
    EmailsSaver.save(gmail_account, @filtered_emails)
  end

  def start_date
    @gmail_account.last_mail_date - 1.day
  end

  def start_uid
    @gmail_account.last_mail_uid || 0
  end

end