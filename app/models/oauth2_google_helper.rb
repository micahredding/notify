class Oauth2GoogleHelper

  def self.get_authorize_url email
    get_client.auth_code.authorize_url(:scope => "https://mail.google.com",
                                       :access_type => "offline",
                                       :redirect_uri => ENV["GOOGLE_APP_REDIRECT_URI"],
                                       :approval_prompt => 'force',
                                       :user_id => email)
  end

  def self.get_access_token_from_code code
    get_client.auth_code.get_token(code, {:redirect_uri => ENV["GOOGLE_APP_REDIRECT_URI"], :token_method => :post})
  end

  private

  def self.get_client
    OAuth2::Client.new(ENV["GOOGLE_APP_ID"], ENV["GOOGLE_APP_SECRET"],
                       {:site => 'https://accounts.google.com',
                        :authorize_url => "/o/oauth2/auth",
                        :token_url => "/o/oauth2/token"})
  end

end