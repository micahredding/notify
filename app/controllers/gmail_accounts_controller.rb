class GmailAccountsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @gmail_accounts = current_user.gmail_accounts.decorate
  end

  def create
    @gmail_account = current_user.gmail_accounts.build(params[:gmail_account])

    if @gmail_account.save
      flash[:notice] = "Gmail account added successfully"
    else
      flash[:alert] = "Couldn't add Gmail account : #{@gmail_account.errors.full_messages.join(', ')}"
    end

  end

  def destroy
    gmail_account = current_user.gmail_accounts.find(params[:id])
    gmail_account.destroy
  end

  def activate
    gmail_account = current_user.gmail_accounts.find(params[:id])
    session[:gmail_account_to_activate] = gmail_account.email

    url = Oauth2GoogleHelper.get_authorize_url(gmail_account.email)
    redirect_to url
  end

  def oauth2callback
    redirect_to(edit_user_registration_path) and return unless params[:code]

    access_token = Oauth2GoogleHelper.get_access_token_from_code params[:code]

    if session[:gmail_account_to_activate] && access_token && access_token.token && access_token.refresh_token
      gmail_account = current_user.gmail_accounts.find_by_email(session[:gmail_account_to_activate])
      gmail_account.update_attributes(:token => access_token.token, :refresh_token => access_token.refresh_token)
      flash[:notice] = "Gmail account activated successfully"
    end

    redirect_to edit_user_registration_path
  end

end
