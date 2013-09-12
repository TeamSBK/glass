module Glass
  module Config
    class << self
      attr_accessor :app_name
      attr_accessor :models
      attr_accessor :format
      attr_accessor :routes

      def reset
        @app_name = ''
        @models = []
        @format = :json
        @routes = ''
      end

      def models_with_routes
        @models.map do |model|
          { model => create_routes(model) }
        end
      end

      def create_routes(model)
        model_scope = model.pluralize.downcase

        return { "routes" => {
          "index"   => { "get"      => "/#{model_scope}"      },
          "new"     => { "get"      => "/#{model_scope}"      },
          "show"    => { "get"      => "/#{model_scope}/:id"  },
          "edit"    => { "get"      => "/#{model_scope}/:id/edit" },
          "create"  => { "post"     => "/#{model_scope}"      },
          "update"  => { "put"      => "/#{model_scope}/:id"  },
          "destroy" => { "delete"   => "/#{model_scope}/:id"  }
        } }
      end

      def setup
        @routes = models_with_routes
      end
    end
    self.reset
  end
end
