class Notification < ActiveRecord::Base
  attr_accessible :body, :email_id, :gmail_account_id, :read, :user_id

  belongs_to :gmail_account
  belongs_to :user
  belongs_to :email
end
