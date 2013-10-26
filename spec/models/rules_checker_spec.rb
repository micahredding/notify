require 'spec_helper'

describe RulesChecker do

  let(:message) { double }
  let(:email) { double(:message => message) }
  let(:rule1) { double }
  let(:rule2) { double }
  let(:rules) { [rule1,rule2] }
  let(:gmail_account) { double(:rules => rules) }

  it "2 ok" do
    SingleRuleChecker.stub(:new).with(rule1, message) { double(:check => true) }
    SingleRuleChecker.stub(:new).with(rule2, message) { double(:check => true) }

    RulesChecker.new(gmail_account).check(email).should be_true
  end

  it "1 ok" do
    SingleRuleChecker.stub(:new).with(rule1, message) { double(:check => false) }
    SingleRuleChecker.stub(:new).with(rule2, message) { double(:check => true) }

    RulesChecker.new(gmail_account).check(email).should be_true
  end

  it "no" do
    SingleRuleChecker.stub(:new).with(rule1, message) { double(:check => false) }
    SingleRuleChecker.stub(:new).with(rule2, message) { double(:check => false) }

    RulesChecker.new(gmail_account).check(email).should be_false
  end

end