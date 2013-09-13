require 'spec_helper'

describe Glass::Config do
  before :each do
    Glass::Config.models = %w{Pete Robbie Joko}
  end

  describe '#reset' do
    it 'resets the configuration for Glass Module' do
      # Uses the models attribute as sample basis for resetting
      expect(Glass::Config.models).to eq (['Pete', 'Robbie', 'Joko'])

      Glass::Config.reset

      expect(Glass::Config.models).to eq ([])
    end
  end

  describe '#models_with_routes' do

    before :each do
      Glass::Config.models_with_routes
    end

    it 'creates routes from the inputted models' do
      expect(Glass::Config.routes).to_not be_nil
    end

    context 'CRUD' do

      it 'creates #index' do
        index_route = Glass::Config.routes[:pete]['index']

        expect(index_route).to_not be_nil
      end

      it 'creates #show' do
        show_route = Glass::Config.routes[:pete]['show']

        expect(show_route).to_not be_nil
      end

      it 'creates #create' do
        create_route = Glass::Config.routes[:pete]['create']

        expect(create_route).to_not be_nil
      end

      it 'creates #update' do
        update_route = Glass::Config.routes[:pete]['update']

        expect(update_route).to_not be_nil
      end

      it 'creates #destroy' do
        destroy_route = Glass::Config.routes[:pete]['destroy']

        expect(destroy_route).to_not be_nil
      end

    end

  end

  describe '#setup' do

    it 'calls the #models_with_routes method' do
      Glass::Config.should_receive(:models_with_routes)

      Glass::Config.setup
    end
  end

  context 'Utility methods' do

    describe '#pluralize_downcase(model)' do

      it 'pluralizes then downcases a string' do
        expect(Glass::Config.pluralize_downcase('Fly')).to eq('flies')
        expect(Glass::Config.pluralize_downcase('User')).to eq('users')
      end

    end

    describe '#capitalize_singularize(model)' do

      it 'capitalizes then singularizes a string' do
        expect(Glass::Config.capitalize_singularize('flies')).to eq('Fly')
        expect(Glass::Config.capitalize_singularize('users')).to eq('User')
      end
    end

  end

end
