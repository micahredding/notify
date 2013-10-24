class Rule < ActiveRecord::Base
  attr_accessible :content_regex, :name, :sender_regex, :subject_regex

  has_many :email_filters, :dependent => :destroy
  has_many :users, :through => :email_filters

  validates_presence_of :name
end
