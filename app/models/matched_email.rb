class MatchedEmail
  attr_accessor :m_sender, :m_subject, :m_content, :notification_text

  def initialize(email)
    @email = email
  end

  def method_missing(method, *args, &block)
    @email.send(method, *args, &block)
  end

end
