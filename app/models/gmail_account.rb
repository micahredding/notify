class GmailAccount < ActiveRecord::Base
  attr_accessible :email, :token, :user_id, :refresh_token

  belongs_to :user

  validates :email, :email_format => {:message => 'is not a valid email address'}

  def active?

  end

end
