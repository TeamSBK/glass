module Glass
  class MainController < Glass::ApplicationController
    def index
      respond_to do |format|
        format.js { render json: Hash.new[:models, Glass::Config.models].to_json }
      end
    end
  end
end
