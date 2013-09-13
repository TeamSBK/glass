require 'spec_helper'

describe Glass::Config do

  context 'default values' do

    describe '#reset' do

      it 'responds to default app name' do
        Glass::Config.app_name = 'Dummy'
        Glass::Config.reset

        expect(Glass::Config.app_name).to eq('')
        expect(Glass::Config.app_name).to_not eq('Dummy')
      end

      it 'responds to default mounted route' do
        Glass::Config.mounted_at = '/dummy'
        Glass::Config.reset

        expect(Glass::Config.mounted_at).to eq('/api')
        expect(Glass::Config.mounted_at).to_not eq('/dummy')
      end

      it 'responds to default models' do
        Glass::Config.models = ['Pete', 'Robbie', 'Joko']
        Glass::Config.reset

        expect(Glass::Config.models).to eq([])
        expect(Glass::Config.models).to_not eq(['Pete', 'Robbie', 'Joko'])
      end

      it 'responds to default format' do
        Glass::Config.format = :xml
        Glass::Config.reset

        expect(Glass::Config.format).to eq(:json)
        expect(Glass::Config.format).to_not eq(:xml)
      end

      it 'responds to default routes' do
        Glass::Config.models = ['Pete', 'Robbie', 'Joko']
        Glass::Config.routes = Glass::Config.setup
        Glass::Config.reset

        expect(Glass::Config.routes).to eq({})
        expect(Glass::Config.routes).to_not eq(Glass::Config.setup)
      end

    end
  end

  describe '#models_with_routes' do

    before :each do
      Glass::Config.models = %w{Pete Robbie Joko}
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
