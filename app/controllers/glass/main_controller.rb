module Glass
  class MainController < Glass::ApplicationController
    before_filter :setup_config
    before_filter :define_orm

    def index
      render json: Glass::Config.to_json
    end

  private
    def setup_config
      Glass::Config.setup
    end

    def define_orm
      Glass::DefineOrm.new(Glass::Config.models)
    end

  end
end
