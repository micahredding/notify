class NotificationTextBuilder

  def initialize rule, email
    @rule, @email = rule, email
  end

  def build
    result = nil

    begin
      notification_template = @rule.notification_text

      m_sender = @email.m_sender
      m_subject = @email.m_subject
      m_content = @email.m_content

      result = eval("\"" + notification_template + "\"")
    rescue StandardError => ex
      Rails.logger.error "Failed to build notification text : #{ex.message}"
    end

    result
  end

end