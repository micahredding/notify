require 'spec_helper'

describe EmailsFetcher do

  let(:rules_checker) { double }
  let(:emails_saver) { double }

  let(:inbox) { double }
  let(:gmail) { double(:inbox => inbox) }

  let(:new_last_mail_date) { Time.local(2013, 8, 5, 6, 42) }

  let(:email1) { double(:uid => 255) }
  let(:email2) { double(:uid => 345) }
  let(:email3) { double(:uid => 448, :message => double(:date => new_last_mail_date)) }
  let(:emails) { [email1, email2, email3] }

  let(:matched_email2) {double}

  let(:email) { "m@il.com" }
  let(:token) { "C14652" }
  let(:last_mail_date) { Time.local(2013, 8, 2, 5, 45) }
  let(:last_mail_uid) { 280 }

  let(:gmail_account) { FactoryGirl.create(:gmail_account,
                                           :email => email,
                                           :token => token,
                                           :last_mail_date => last_mail_date,
                                           :last_mail_uid => last_mail_uid) }

  context "fetch" do

    before do
      rules_checker.stub(:check).with(email2) { matched_email2 }
      rules_checker.stub(:check).with(email3) { nil }

      RulesChecker.stub(:new).with(gmail_account) { rules_checker }
      EmailsSaver.stub(:new).with(gmail_account) { emails_saver }

      inbox.stub(:emails).with(:all, :after => (last_mail_date - 1.day)) { emails }
      Gmail.stub(:connect).with(:xoauth2, email, token) { gmail }
    end

    it "ok" do
      Timecop.freeze do
        emails_saver.should_receive(:save).with([matched_email2]) { true }

        EmailsFetcher.new(gmail_account).fetch

        gmail_account.reload.last_mail_uid.should eq email3.uid
        gmail_account.last_mail_date.should eq new_last_mail_date
      end
    end

    it "save issue" do
      emails_saver.should_receive(:save).with([matched_email2]) { false }

      EmailsFetcher.new(gmail_account).fetch

      gmail_account.reload.last_mail_uid.should eq last_mail_uid
      gmail_account.last_mail_date.should eq last_mail_date
    end

  end

end