require 'spec_helper'

describe GmailAccount do

  it "overdue" do
    FactoryGirl.create(:gmail_account)
    account1 = FactoryGirl.create(:gmail_account, :token => "21325")
    account2 = FactoryGirl.create(:gmail_account, :token => "21325", :checked_at => (GmailAccount::CHECK_INTERVAL + 5.minutes).ago)
    FactoryGirl.create(:gmail_account, :token => "21325", :checked_at => (GmailAccount::CHECK_INTERVAL - 5.minutes).ago)
    GmailAccount.overdue.to_a.should =~[account1, account2]
  end

  it "active" do
    FactoryGirl.create(:gmail_account)
    account1 = FactoryGirl.create(:gmail_account, :token => "21325")
    account2 = FactoryGirl.create(:gmail_account, :token => "54619")

    GmailAccount.active.to_a.should =~ [account1, account2]
  end

end
