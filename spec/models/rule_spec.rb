require 'spec_helper'

describe Rule do

  it "active for user" do
    rule = FactoryGirl.create(:rule)
    user = FactoryGirl.create(:user)

    FactoryGirl.create(:email_filter, :user_id => user.id + 1, :rule_id => rule.id)
    FactoryGirl.create(:email_filter, :user_id => user.id, :rule_id => rule.id + 1)
    rule.reload.active_for?(user).should be_false

    FactoryGirl.create(:email_filter, :user_id => user.id, :rule_id => rule.id)
    rule.reload.active_for?(user).should be_true
  end

end
