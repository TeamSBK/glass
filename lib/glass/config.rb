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
        @routes = {}
      end

      def models_with_routes
        @models.each do |model|
          @routes[model.downcase.to_sym] = create_routes(model)
        end
      end

      def create_routes(model)
        model_scope = model.pluralize.downcase
        model_name = model.capitalize.singularize

        return "routes" => { "#{model_name}" => {
            "index"   => { "type" => "get",   "path" => "/#{model_scope}"      },
            "show"    => { "type" => "get",   "path" => "/#{model_scope}/:id"  },
            "create"  => { "type" => "post",  "path" => "/#{model_scope}"      },
            "update"  => { "type" => "put",   "path" => "/#{model_scope}/:id"  },
            "destroy" => { "type" => "delete","path" => "/#{model_scope}/:id"  } } }
      end

      def setup
        models_with_routes
      end

    end
    self.reset
  end
end
