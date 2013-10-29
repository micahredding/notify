require 'spec_helper'

describe EmailBodyBuilder do

  context "builds" do

    let(:body) { "The body" }
    let(:body2) { "Second body" }

    context "single part" do
      let(:message) { double(:multipart? => false,
                             :body => double(:decoded => body)) }
      let(:email) { double(:message => message) }

      it "ok" do
        EmailBodyBuilder.new(email).build.should eq body
      end

    end

    context "multi part" do
      let(:body) { "The body" }
      let(:message) { double(:multipart? => true,
                             :parts => [double(:body => double(:decoded => body)), double(:body => double(:decoded => body2))]) }

      let(:email) { double(:message => message) }

      it "ok" do
        EmailBodyBuilder.new(email).build.should eq (body+body2)
      end

    end

  end

end