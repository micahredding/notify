class EmailsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @email = current_user.emails.find(params[:id]).decorate
  end

end
