class EmailFiltersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @rules = Rule.scoped
  end

  def activate
    email_filter = current_user.email_filters.build(:rule_id => params[:id])

    unless email_filter.save
      flash[:alert] = "Couldn't activate rule : #{email_filter.errors.full_messages.join(', ')}"
    end
  end

  def deactivate
    current_user.email_filters.where(:rule_id => params[:id]).destroy_all
  end

end
