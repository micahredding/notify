require 'spec_helper'

describe TokenRefresher do

  let(:old_token) { "SDSD" }
  let(:refresh_token) { "sdlk5dsalk" }
  let(:new_token) { "SADASDE" }
  let(:access_token) { double(:token => new_token) }
  let(:gmail_account) { FactoryGirl.create(:gmail_account, :token => old_token, :refresh_token => refresh_token) }
  let(:token_refresher) { TokenRefresher.new(gmail_account.id) }

  context 'refreshes token' do

    it "ok" do
      Oauth2GoogleHelper.stub(:get_new_access_token).with(refresh_token) { access_token }

      token_refresher.refresh

      gmail_account.reload.token.should eq new_token
    end

    it "error" do
      Oauth2GoogleHelper.stub(:get_new_access_token).with(refresh_token) { nil }

      token_refresher.refresh

      gmail_account.reload.token.should eq old_token
    end

  end
end