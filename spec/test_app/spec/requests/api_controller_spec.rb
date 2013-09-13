require 'spec_helper'

describe Glass::ApiController, type: :controller  do
  context "#index" do
    it "should be successful" do
      get '/api/users', format: :json
      response.body.should == User.all.to_json
      response.should be_success
    end
  end

  context "#show" do
    it "should be successful" do
      get '/api/user/1', format: :json
      response.body.should == User.first.to_json
      response.should be_success
    end
  end

  context "#create" do
    it "should be successful" do
      post '/api/users', {:name => "blabla"}
      response.should be_successful
      User.last.name.should == "blabla"
    end
  end
  context "#update" do
    it "should be successful" do
      put '/api/users/1', {:name => "changedname"}
      response.should be_successful
      User.find(1).name.should == "changedname"
    end
  end

  context "#destroy" do
    it "should be successful" do
      pending "how to do this?"
      #delete :destroy, :id => "1"
      #response.should be_successful
      #User.find(1).should be_nil
    end
  end

end
