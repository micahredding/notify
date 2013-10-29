require 'spec_helper'

describe NotificationTextBuilder do

  context "builds" do

    let(:notification_template) { 'New comments from #{m_sender[:name]}, #{m_subject[:number]} to be exact' }
    let(:rule) { double(:notification_text => notification_template) }

    let(:m_sender) { Regexp.new("(?<name>.+)@yahoo\.com").match("mike@yahoo.com") }
    let(:m_subject) { Regexp.new("(?<number>\\d+) of comments on your post").match("11 of comments on your post") }
    let(:m_content) { nil }
    let(:email) { double(:m_sender => m_sender, :m_subject => m_subject, :m_content => m_content) }

    it "ok" do
      email = double(:m_sender => m_sender, :m_subject => m_subject, :m_content => m_content)
      NotificationTextBuilder.new(rule, email).build.should eq 'New comments from mike, 11 to be exact'
    end

    it "error" do
      email = double(:m_sender => nil, :m_subject => nil, :m_content => nil)
      NotificationTextBuilder.new(rule, email).build.should be_nil
    end

  end

end