class EmailFilter < ActiveRecord::Base
  attr_accessible :rule_id, :user_id

  belongs_to :user
  belongs_to :rule
end
