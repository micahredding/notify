require 'spec_helper'

describe SingleRuleChecker do

  let(:rule) { FactoryGirl.build(:rule) }
  let(:email_address) { "mike@yahoo.com" }
  let(:subject) { "Transaction succeeded" }
  let(:body) { "We are pleased to inform you" }
  let(:body2) { "You have been selected for the event" }

  context "checks" do

    context "single part message" do

      let(:message) { double(:multipart? => false, :from => [email_address], :subject => subject, :body => body) }

      it "ok" do
        rule.sender_regex = "(mike|john)@yahoo"
        rule.subject_regex = "^Transaction"
        rule.content_regex = "inform you$"

        SingleRuleChecker.new(rule, message).check.should be_true
      end

      it "ok rule blank" do
        rule.sender_regex = "(mike|john)@yahoo"
        rule.subject_regex = "^Transaction"

        SingleRuleChecker.new(rule, message).check.should be_true
      end

      it "nok" do
        rule.sender_regex = "(mike|john)@yahoo"
        rule.subject_regex = "(important|urgent)"

        SingleRuleChecker.new(rule, message).check.should be_false
      end

    end

    context "multipart message" do

      let(:message) { double(:multipart? => true, :from => [email_address], :subject => subject,
                             :parts => [double(:body => body), double(:body => body2)]) }

      it "ok" do
        rule.sender_regex = "(mike|john)@yahoo"
        rule.subject_regex = "^Transaction"
        rule.content_regex = "selected for"

        SingleRuleChecker.new(rule, message).check.should be_true
      end

      it "nok" do
        rule.sender_regex = "(mike|john)@yahoo"
        rule.subject_regex = "(important|urgent)"

        SingleRuleChecker.new(rule, message).check.should be_false
      end

    end

  end

end