class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @notifications = current_user.notifications.recent.decorate
  end

  def read
    notification = current_user.notifications.find(params[:id])
    notification.update_attributes(:read => true)
  end

end
