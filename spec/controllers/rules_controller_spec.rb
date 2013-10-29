require 'spec_helper'

describe RulesController do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    user.add_role "admin"
    sign_in user
  end

  let(:valid_attributes) { { "name" => "MyString" , "notification_text" => "Text" } }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all rules as @rules" do
      rule = Rule.create! valid_attributes
      get :index, {}
      assigns(:rules).should eq([rule])
    end
  end

  describe "GET show" do
    it "assigns the requested rule as @rule" do
      rule = Rule.create! valid_attributes
      get :show, {:id => rule.to_param}
      assigns(:rule).should eq(rule)
    end
  end

  describe "GET new" do
    it "assigns a new rule as @rule" do
      get :new, {}
      assigns(:rule).should be_a_new(Rule)
    end
  end

  describe "GET edit" do
    it "assigns the requested rule as @rule" do
      rule = Rule.create! valid_attributes
      get :edit, {:id => rule.to_param}
      assigns(:rule).should eq(rule)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Rule" do
        expect {
          post :create, {:rule => valid_attributes}
        }.to change(Rule, :count).by(1)
      end

      it "assigns a newly created rule as @rule" do
        post :create, {:rule => valid_attributes}
        assigns(:rule).should be_a(Rule)
        assigns(:rule).should be_persisted
      end

      it "redirects to the created rule" do
        post :create, {:rule => valid_attributes}
        response.should redirect_to(Rule.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved rule as @rule" do
        # Trigger the behavior that occurs when invalid params are submitted
        Rule.any_instance.stub(:save).and_return(false)
        post :create, {:rule => { "name" => "invalid value" }}
        assigns(:rule).should be_a_new(Rule)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Rule.any_instance.stub(:save).and_return(false)
        post :create, {:rule => { "name" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested rule" do
        rule = Rule.create! valid_attributes
        # Assuming there are no other rules in the database, this
        # specifies that the Rule created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Rule.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => rule.to_param, :rule => { "name" => "MyString" }}
      end

      it "assigns the requested rule as @rule" do
        rule = Rule.create! valid_attributes
        put :update, {:id => rule.to_param, :rule => valid_attributes}
        assigns(:rule).should eq(rule)
      end

      it "redirects to the rule" do
        rule = Rule.create! valid_attributes
        put :update, {:id => rule.to_param, :rule => valid_attributes}
        response.should redirect_to(rule)
      end
    end

    describe "with invalid params" do
      it "assigns the rule as @rule" do
        rule = Rule.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Rule.any_instance.stub(:save).and_return(false)
        put :update, {:id => rule.to_param, :rule => { "name" => "invalid value" }}
        assigns(:rule).should eq(rule)
      end

      it "re-renders the 'edit' template" do
        rule = Rule.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Rule.any_instance.stub(:save).and_return(false)
        put :update, {:id => rule.to_param, :rule => { "name" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested rule" do
      rule = Rule.create! valid_attributes
      expect {
        delete :destroy, {:id => rule.to_param}
      }.to change(Rule, :count).by(-1)
    end

    it "redirects to the rules list" do
      rule = Rule.create! valid_attributes
      delete :destroy, {:id => rule.to_param}
      response.should redirect_to(rules_url)
    end
  end

end
