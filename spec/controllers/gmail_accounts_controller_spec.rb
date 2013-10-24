require 'spec_helper'

describe GmailAccountsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:gmail_accounts) { double }
  let(:gmail_account) { double }
  let(:id) { "12" }
  let(:email) { "m@il.com" }
  let(:url) { "/google_auth_url" }

  before(:each) do
    sign_in user
    controller.stub(:current_user).and_return(user)
    user.stub(:gmail_accounts) { gmail_accounts }
  end

  it "index" do
    user.stub_chain(:gmail_accounts, :decorate) { gmail_accounts }

    xhr :get, :index
    assigns(:gmail_accounts).should eq gmail_accounts
  end

  context "creates" do
    let(:attrs) { "test" }

    before do
      gmail_accounts.stub(:build).with(attrs) { gmail_account }
    end

    it "ok" do
      gmail_account.stub(:save) { true }

      xhr :post, :create, :gmail_account => attrs

      flash[:notice].should eq "Gmail account added successfully"
    end

    it "error" do
      error_text = "text"
      gmail_account.stub(:save) { false }
      gmail_account.stub_chain(:errors, :full_messages) { [error_text] }


      xhr :post, :create, :gmail_account => attrs

      flash[:alert].should eq "Couldn't add Gmail account : #{error_text}"
    end

  end

  it "destroys" do
    gmail_account.should_receive(:destroy)
    gmail_accounts.stub(:find).with(id) { gmail_account }

    xhr :delete, :destroy, :id => id
  end

  it "activates" do
    gmail_account.stub(:email => email)
    gmail_accounts.stub(:find).with(id) { gmail_account }

    Oauth2GoogleHelper.stub(:get_authorize_url).with(email) { url }

    get :activate, :id => id

    session[:gmail_account_to_activate].should eq email
    response.should redirect_to url
  end

  context "oauth2callback" do

    let(:code) { "code" }
    let(:token) { "token" }
    let(:refresh_token) { "refresh_token" }
    let(:access_token) { double(:token => token, :refresh_token => refresh_token) }

    it "ok" do
      session[:gmail_account_to_activate] = email
      Oauth2GoogleHelper.stub(:get_access_token_from_code).with(code) { access_token }

      gmail_account.should_receive(:update_attributes).with(:token => token, :refresh_token => refresh_token)
      gmail_accounts.stub(:find_by_email).with(email) { gmail_account }

      get :oauth2callback, :code => code

      response.should redirect_to edit_user_registration_path
      flash[:notice].should eq "Gmail account activated successfully"
    end

    it "no code" do
      get :oauth2callback

      response.should redirect_to edit_user_registration_path
    end

  end

end
