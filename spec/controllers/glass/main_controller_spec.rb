require 'spec_helper'

describe Glass::MainController do

  let(:setup){
    Glass.configure do |config|
      config.models   = ['User', 'Post']
      config.app_name = 'TestApp'
      config.format   = :json
    end
  }

  before(:each) {
    setup
    Glass::Config.setup
  }

  describe "#index" do

    it "returns the Glass configuration" do
      pending
    end

  end

  describe "methods" do

    describe "#setup_config" do

      it "returns true when successful" do
        expect(Glass::Config.setup).to be_true
      end

      it "assigns mounted_at" do
        expect(Glass::Config.mounted_at).to eql '/api'
      end

      it "assigns routes" do
        expect(Glass::Config.routes.to_json).to include 'user'
      end

    end

  end

end
