class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    if request.xhr?
      flash.now[:alert] = exception.message
      render "layouts/not_authorized"
    else
      redirect_to root_path, :alert => exception.message
    end
  end

  def authorize_admin!
    unless current_user.has_role?("admin")
      redirect_to root_path, :alert => 'Not authorized as admin.'
    end
  end

end
