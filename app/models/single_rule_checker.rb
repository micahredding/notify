class SingleRuleChecker

  def initialize rule, email, gmail_account_id
    @rule = rule
    @message = email.message
    @matched_email = MatchedEmail.new(email)
    @gmail_account_id = gmail_account_id
  end

  def check
    return unless check_all_fields

    build_notification_text
    @matched_email if @matched_email.notification_text
  end

  def check_all_fields
    check_sender && check_subject && check_content
  end

  def build_notification_text
    @matched_email.notification_text = NotificationTextBuilder.new(@rule, @matched_email,@gmail_account_id).build
  end

  private

  def check_sender
    return true unless @rule.sender_regex.present?

    sender_email_address = @message.from[0] if (@message.from && @message.from.any?)
    @matched_email.m_sender = Regexp.new(@rule.sender_regex).match(sender_email_address)

    true if @matched_email.m_sender
  end

  def check_subject
    return true unless @rule.subject_regex.present?

    @matched_email.m_subject = Regexp.new(@rule.subject_regex).match(@message.subject)

    true if @matched_email.m_subject
  end

  def check_content
    return true unless @rule.content_regex.present?

    if @message.multipart?
      check_content_multipart
    else
      check_content_singlepart
    end
  end

  def check_content_multipart
    @message.parts.each do |part|
      return true if check_body(part.body)
    end
  end

  def check_content_singlepart
    check_body(@message.body)
  end

  def check_body(body)
    @matched_email.m_content = Regexp.new(@rule.content_regex).match(body.decoded)
    true if @matched_email.m_content
  end

end