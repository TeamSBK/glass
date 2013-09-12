module Glass
  class ApiController < Glass::ApplicationController
    before_filter :sanitize_model
    before_filter :sanitize_params, only: [:create, :update]

    respond_to :json

    def index
      render json: @model.all.to_json
    end

    def show
      render json: @model.find(params[:id]).to_json
    end

    def create
      object = @model.new(params[@params])

      if object.save
        render json: object.to_json
      else
        render json: object.errors, status: :unprocessable_entity
      end
    end

    def update
      object = @model.find(params[:id])

      if object.update_attributes(params[@params])
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
      @params = params[:object].downcase.to_sym
    end
  end
end
