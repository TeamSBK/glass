module Glass
  class MainController < Glass::ApplicationController
    before_filter :setup_config

    def index
      respond_to do |format|
        format.html { }
      end
    end

    def config
      respond_to do |format|
        format.html { redirect_to '/api' }
        format.js   { render json: Glass::Config.to_json }
        format.json { render json: Glass::Config.to_json }
      end
    end

  private
    def setup_config
      Glass::Config.setup
    end

  end
end
