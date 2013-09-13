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
      pending "how is this?"
    end
  end
  context "#update" do
    it "should be successful" do
      pending "how is this?"
    end
  end

  context "#destroy" do
    it "should be successful" do
      pending "how is this?"
    end
  end

end
