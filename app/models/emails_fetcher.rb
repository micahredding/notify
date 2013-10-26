class EmailsFetcher

  def initialize gmail_account
    @gmail_account = gmail_account

    @rules_checker = RulesChecker.new(@gmail_account)
    @emails_saver = EmailsSaver.new(@gmail_account)

    @filtered_emails = []
  end

  def fetch
    connect_gmail
    get_emails
    filter_emails
    if save_results
      save_last_email_data
    end
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
    @emails_saver.save(@filtered_emails)
  end

  def save_last_email_data
    last_email = @emails.last

    return unless last_email

    @gmail_account.update_attributes(:last_mail_uid => last_email.uid, :last_mail_date => last_email.message.date)
  end

  def start_date
    @gmail_account.last_mail_date ? (@gmail_account.last_mail_date - 1.day) : nil
  end

  def start_uid
    @gmail_account.last_mail_uid || 0
  end

end