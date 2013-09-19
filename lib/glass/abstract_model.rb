module Glass
  class AbstractModel
    attr_accessor :adapter, :model_names

    def initialize(models)
      @model_names = models

      if models[0].constantize.ancestors.map(&:to_s).include?('ActiveRecord::Base')
        # ActiveRecord
        @adapter = :active_record
        Glass::Config.adapter = @adapter

      elsif models[0].constantize.ancestors.map(&:to_s).include?('Mongoid::Document')
        # Mongoid
        @adapter = :mongoid
        Glass::Config.adapter = @adapter

        define_column_names(@model_names)
      end

    end

    def define_column_names(model_names)
      model_names.each do |model|
        model.constantize.instance_eval do
          def column_names
            self.fields.collect { |field| field[0].tr('^A-Za-z0-9', '') }
          end
        end
      end
    end

  end
end

