require 'spec_helper'

describe EmailsSaver do

  let(:user_id) { 34 }
  let(:gmail_account) { FactoryGirl.create(:gmail_account, :user_id => user_id) }
  let(:emails_saver) { EmailsSaver.new(gmail_account) }
  let(:message1) { double(:date => 5.days.ago, :subject => "HEllo world", :from => ["mike@yahoo.com"]) }
  let(:message2) { double(:date => 2.days.ago, :subject => "Greetings", :from => ["jack@aol.com"]) }
  let(:email1) { double(:uid => 546, :message => message1) }
  let(:email2) { double(:uid => 874, :message => message2) }
  let(:emails) { [email1, email2] }

  it "saves" do
    emails_saver.save(emails).should be_true

    gmail_account.emails.count.should eq 2
    db_email1 = gmail_account.emails[0]
    db_email1.date.should eq message1.date
    db_email1.subject.should eq message1.subject
    db_email1.sender.should eq message1.from[0]
    db_email1.uid.should eq email1.uid
    db_email2 = gmail_account.emails[1]
    db_email2.date.should eq message2.date
    db_email2.subject.should eq message2.subject
    db_email2.sender.should eq message2.from[0]
    db_email2.uid.should eq email2.uid

    gmail_account.notifications.count.should eq 2
    notification1 = gmail_account.notifications[0]
    notification1.user_id.should eq user_id
    notification1.email_id.should eq db_email1.id
    notification1.body.should eq message1.subject
    notification1.read.should be_false
    notification2 = gmail_account.notifications[1]
    notification2.user_id.should eq user_id
    notification2.email_id.should eq db_email2.id
    notification2.body.should eq message2.subject
    notification2.read.should be_false
  end

  it "fails" do
    gmail_account.stub_chain(:emails,:create).and_raise
    emails_saver.save(emails).should be_false
  end

end