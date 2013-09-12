require 'spec_helper'

describe Glass::Config do
  before :each do
    Glass::Config.models = ['Pete', 'Robbie', 'Joko']
  end

  describe '#reset' do
    it 'resets the configuration for Glass Module' do
      Glass::Config.reset

      expect(Glass::Config.models).to eq([])
    end
  end

  describe '#models_with_routes' do

    before :each do
      Glass::Config.models_with_routes
    end

    it 'creates routes for input model' do
      expect(Glass::Config.routes).to_not be_nil
    end

    it 'creates #index' do
      index_route = Glass::Config.routes[:pete]['index']

      expect(index_route).to_not be_nil
    end
  end

end
