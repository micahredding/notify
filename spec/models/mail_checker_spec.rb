require 'spec_helper'

describe MailChecker do

  let(:gmail_account) { FactoryGirl.create(:gmail_account) }

  let(:token_refresher) { double }
  let(:emails_fetcher) { double }

  before do
    token_refresher.should_receive(:refresh)
    emails_fetcher.should_receive(:fetch)

    TokenRefresher.stub(:new).with(gmail_account.id) { token_refresher }
    EmailsFetcher.stub(:new).with(gmail_account) { emails_fetcher }
  end

  it "checks" do
    Timecop.freeze do
      MailChecker.new(gmail_account.id).check
      gmail_account.reload.checked_at.to_s.should eq Time.zone.now.to_s
    end
  end

end