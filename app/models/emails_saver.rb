class EmailsSaver

  def initialize gmail_account
    @gmail_account = gmail_account
    @user_id = @gmail_account.user_id
  end

  def save emails
    success = false

    begin
      ActiveRecord::Base.transaction do
        emails.each do |email|
          @email = email
          db_email = save_email
          save_notification(db_email.id)
        end
      end
      success = true
    rescue StandardError => ex
      Rails.logger.error "Could not save email/notification: #{ex.message}"
    end

    success
  end

  private

  def save_email
    @gmail_account.emails.create(:date => email_date, :subject => email_subject, :sender => email_sender, :uid => @email.uid)
  end

  def save_notification db_email_id
    @gmail_account.notifications.create(:date => email_date, :user_id => @user_id, :email_id => db_email_id, :body => notification_body)
  end

  def notification_body
    @email.message.subject
  end

  def email_sender
    @email.message.from[0] if (@email.message.from && @email.message.from.any?)
  end

  def email_subject
    @email.message.subject
  end

  def email_date
    @email.message.date
  end

end