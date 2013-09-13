TestApp::Application.routes.draw do
  mount Glass::Engine => '/api', as: :glass
  root to: "statics#index"
end
