module Glass
  class MainController < Glass::ApplicationController
    before_filter :setup_config

    def index
      render json: Glass::Config.to_json
    end

  private
    def setup_config
      Glass::Config.setup
    end

  end
end
