class Email < ActiveRecord::Base
  attr_accessible :date, :gmail_account_id, :sender, :subject, :body ,:uid

  belongs_to :gmail_account

end
