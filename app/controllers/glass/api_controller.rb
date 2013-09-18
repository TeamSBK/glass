module Glass
  class ApiController < Glass::ApplicationController
    before_filter :sanitize_model
    before_filter :sanitize_params, only: [:create, :update, :index]
    before_filter :validate_model

    respond_to :json

    def index
      begin
        render json: all_or_where(@model) # See Private Method Below
      rescue Exception
        render json: { invalid_parameters: @new_hash }, status: :unprocessable_entity
      end
    end

    def show
      begin
        render json: @model.find(params[:id]).to_json
      rescue Exception => exception
        render json: "#{exception}", status: :unprocessable_entity
      end
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
      begin
        object = @model.find(params[:id])
      rescue Exception => exception
        render json: "#{exception}", status: :unprocessable_entity
      end

      if object.update_attributes(@new_hash)
        render json: object.to_json
      else
        render json: object.errors, status: :unprocessable_entity
      end
    end

    def destroy
      begin
        object = @model.find(params[:id])
      rescue Exception => exception
        render json: "#{exception}", status: :unprocessable_entity
      end

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
      ['utf', 'authenticity_token', 'id', 'controller', 'action', 'model_scope', 'api']
    end

    def all_or_where(model)
      @new_hash.present? ? model.where(@new_hash).to_json : model.all.to_json
    end

  end

end
