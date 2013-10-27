require 'spec_helper'

describe NotificationsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:notifications) { double }
  let(:my_notifications) { double }
  let(:notification_id) { "512" }
  let(:notification) { double }

  before(:each) do
    sign_in user
    controller.stub(:current_user).and_return(user)
    user.stub(:notifications) { notifications }
  end

  it "index" do
    notifications.stub_chain(:recent, :decorate) { my_notifications }

    xhr :get, :index

    assigns(:notifications).should eq my_notifications
  end


  it "reads" do
    notification.should_receive(:update_attributes).with(:read => true)
    notifications.stub(:find).with(notification_id) { notification }

    xhr :post, :read, :id => notification_id
  end

end
