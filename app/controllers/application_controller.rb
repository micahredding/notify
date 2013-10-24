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
end
