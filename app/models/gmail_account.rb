class GmailAccount < ActiveRecord::Base

  CHECK_INTERVAL = 1.hour

  attr_accessible :email, :token, :user_id, :refresh_token, :last_mail_uid, :last_mail_date ,:checked_at

  belongs_to :user
  has_many :emails, :dependent => :destroy
  has_many :notifications, :dependent => :destroy

  validates :email, :email_format => {:message => 'is not a valid email address'}

  scope :overdue, lambda { active.where("checked_at < ? OR checked_at is null", CHECK_INTERVAL.ago) }

  scope :active, lambda { where("token is not null") }

  def active?

  end

end
