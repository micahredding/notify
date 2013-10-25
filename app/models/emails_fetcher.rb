class EmailsFetcher

  def initialize gmail_account
    @gmail_account = gmail_account
  end

  def fetch
    # refresh token ?
    gmail = Gmail.connect(:xoauth2, @gmail_account.email, @gmail_account.token)
  end

end