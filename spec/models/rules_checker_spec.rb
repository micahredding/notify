require 'spec_helper'

describe RulesChecker do

  let(:email) { double }
  let(:rule1) { double }
  let(:rule2) { double }
  let(:rules) { [rule1, rule2] }
  let(:user) { double(:rules => rules) }
  let(:gmail_account) { double(:user => user) }

  let(:matched_email1) { double }
  let(:matched_email2) { double }

  it "2 ok" do
    SingleRuleChecker.stub(:new).with(rule1, email) { double(:check => matched_email1) }
    SingleRuleChecker.stub(:new).with(rule2, email) { double(:check => matched_email2) }

    RulesChecker.new(gmail_account).check(email).should eq matched_email1
  end

  it "1 ok" do
    SingleRuleChecker.stub(:new).with(rule1, email) { double(:check => nil) }
    SingleRuleChecker.stub(:new).with(rule2, email) { double(:check => matched_email2) }

    RulesChecker.new(gmail_account).check(email).should eq matched_email2
  end

  it "no" do
    SingleRuleChecker.stub(:new).with(rule1, email) { double(:check => nil) }
    SingleRuleChecker.stub(:new).with(rule2, email) { double(:check => nil) }

    RulesChecker.new(gmail_account).check(email).should be_nil
  end

end