Glass::Engine.routes.draw do
  controller "main" do
    get '/',              to: :index,     as: 'glass'
    get '/glass/config',  to: :config,    as: 'config'
  end

  controller "api" do
    get     '/:model_scope',      to: :index,     as: 'index',    via: 'get'
    get     '/:model_scope/:id',  to: :show,      as: 'show',     via: 'get'
    post    '/:model_scope',      to: :create,    as: 'create',   via: 'post'
    put     '/:model_scope/:id',  to: :update,    as: 'update',   via: 'put'
    delete  '/:model_scope/:id',  to: :delete,    as: 'destroy',  via: 'delete'
  end
end
