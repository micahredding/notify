class SingleRuleChecker

  def initialize rule, message
    @rule, @message = rule, message
  end

  def check
    check_sender && check_subject && check_content
  end

  private

  def check_sender
    return true unless @rule.sender_regex.present?

    sender_email_address = @message.from[0] if (@message.from && @message.from.any?)
    Regexp.new(@rule.sender_regex).match(sender_email_address)
  end

  def check_subject
    return true unless @rule.subject_regex.present?

    Regexp.new(@rule.subject_regex).match(@message.subject)
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
    Regexp.new(@rule.content_regex).match(body.decoded)
  end

end