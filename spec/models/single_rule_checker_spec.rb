require 'spec_helper'

describe SingleRuleChecker do

  let(:rule) { FactoryGirl.build(:rule) }
  let(:email_address) { "mike@yahoo.com" }
  let(:subject) { "Transaction succeeded" }
  let(:body) { "We are pleased to inform you" }
  let(:body2) { "You have been selected for the event" }
  let(:notification_text_builder) { double }
  let(:notification_text) { "Notification text" }

  context "checks" do

    before do
      notification_text_builder.stub(:build) { notification_text }
      NotificationTextBuilder.stub(:new).with(rule, an_instance_of(MatchedEmail)) { notification_text_builder }
    end

    context "single part message" do

      let(:message) { double(:multipart? => false, :from => [email_address], :subject => subject, :body => double(:decoded => body)) }
      let(:email) { double(:message => message) }

      it "ok" do
        rule.sender_regex = "(?<name>mike|john)@yahoo"
        rule.subject_regex = "^Transaction"
        rule.content_regex = "inform you$"

        matched_email = SingleRuleChecker.new(rule, email).check
        matched_email.should be_instance_of(MatchedEmail)
        matched_email.m_sender[:name].should eq "mike"
        matched_email.notification_text.should eq notification_text
      end

      it "ok rule nil" do
        rule.sender_regex = "(mike|john)@yahoo"
        rule.subject_regex = "(?<operation>^Transaction)"

        matched_email = SingleRuleChecker.new(rule, email).check
        matched_email.should be_instance_of(MatchedEmail)
        matched_email.m_subject[:operation].should eq "Transaction"
        matched_email.notification_text.should eq notification_text
      end

      it "ok rule blank" do
        rule.sender_regex = "(mike|john)@yahoo"
        rule.subject_regex = "^Transaction"
        rule.content_regex = "   "

        matched_email = SingleRuleChecker.new(rule, email).check
        matched_email.should be_instance_of(MatchedEmail)
        matched_email.notification_text.should eq notification_text
      end

      it "nok" do
        rule.sender_regex = "(mike|john)@yahoo"
        rule.subject_regex = "(important|urgent)"

        SingleRuleChecker.new(rule, email).check.should be_nil
      end

    end

    context "multipart message" do

      let(:message) { double(:multipart? => true, :from => [email_address], :subject => subject,
                             :parts => [double(:body => double(:decoded => body)), double(:body => double(:decoded => body2))]) }
      let(:email) { double(:message => message) }

      it "ok" do
        rule.sender_regex = "(mike|john)@yahoo"
        rule.subject_regex = "^Transaction"
        rule.content_regex = "selected for"

        matched_email = SingleRuleChecker.new(rule, email).check
        matched_email.should be_instance_of(MatchedEmail)
        matched_email.notification_text.should eq notification_text
      end

      it "nok" do
        rule.sender_regex = "(mike|john)@yahoo"
        rule.subject_regex = "(important|urgent)"

        SingleRuleChecker.new(rule, email).check.should be_nil
      end

    end

  end

end