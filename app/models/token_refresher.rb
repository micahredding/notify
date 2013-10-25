class TokenRefresher
  def initialize gmail_account_id
    @gmail_account = GmailAccount.find(gmail_account_id)
  end

  def refresh
    access_token = Oauth2GoogleHelper.get_new_access_token(@gmail_account.refresh_token)

    if access_token
      @gmail_account.update_attributes(:token => access_token.token, :refresh_token => access_token.refresh_token)
    end

  end

end