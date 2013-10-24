class GmailAccountDecorator < Draper::Decorator
  delegate_all

  def active?
    token.present? ? "True" : "False"
  end

end
