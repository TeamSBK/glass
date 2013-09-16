module Glass
  class ApiController < Glass::ApplicationController
    before_filter :sanitize_model
    before_filter :sanitize_params, only: [:create, :update]
    before_filter :validate_model

    respond_to :json

    def index
      render json: @model.all.to_json
    end

    def show
      render json: @model.find(params[:id]).to_json
    end

    def create
      object = @model.new(@new_hash)

      if object.save
        render json: object.to_json
      else
        render json: object.errors, status: :unprocessable_entity
      end
    end

    def update
      object = @model.find(params[:id])

      if object.update_attributes(@new_hash)
        render json: object.to_json
      else
        render json: object.errors, status: :unprocessable_entity
      end
    end

    def destroy
      object = @model.find(params[:id])

      if object.delete
        render json: 'Successfully deleted'
      else
        render json: 'Unable to delete entity', status: :unprocessable_entity
      end
    end

  private
    def sanitize_model
      @model = params[:model_scope].capitalize.singularize.constantize
    end

    def sanitize_params
      @new_hash = {}

      params.each do |key, value|
        @new_hash[key.to_sym] = value unless ignored_keys.include? key
      end
    end

    def validate_model
      render json: "uninitialized constant #{@model}", status: :unprocessable_entity unless defined?(@model)
    end

    def ignored_keys
      ['utf', 'authenticity_token', 'id', 'controller', 'action', 'model_scope']
    end
  end
end
