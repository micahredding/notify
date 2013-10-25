require 'spec_helper'

describe EmailFiltersController do

  let(:user) { FactoryGirl.create(:user) }
  let(:email_filters) { double }
  let(:rule_id) { "12" }
  let(:error_text) { "error" }

  before(:each) do
    sign_in user
    controller.stub(:current_user).and_return(user)
    user.stub(:email_filters) { email_filters }
  end

  it "index" do
    rules = double
    Rule.stub(:scoped) { rules }

    xhr :get, :index

    assigns(:rules).should eq rules
  end

  context "activate" do
    let(:email_filter) { double }

    before do
      email_filters.stub(:build).with(:rule_id => rule_id) { email_filter }
    end

    it "ok" do
      email_filter.stub(:save) { true }

      xhr :post, :activate, :id => rule_id

      flash[:alert].should be_nil
    end

    it "errors" do
      email_filter.stub(:save) { false }
      email_filter.stub_chain(:errors,:full_messages) {[error_text]}

      xhr :post, :activate, :id => rule_id

      flash[:alert].should eq "Couldn't activate rule : #{error_text}"
    end

  end

  it "deactivate" do
    email_filters_to_delete = double
    email_filters_to_delete.should_receive(:destroy_all)
    email_filters.stub(:where).with(:rule_id => rule_id) { email_filters_to_delete }

    xhr :post, :deactivate, :id => rule_id
  end

end
