class NotificationDecorator < Draper::Decorator
  delegate_all

  def read_status
    read ? "read" : "unread"
  end

end
