Glass::Engine.routes.draw do
  controller "main" do
    get '/',        to: :index,     as: 'glass'
    get '/config',  to: :config,    as: 'config'
  end
end
