Correlate::Application.routes.draw do
  devise_for :users
  resources :interests do
    get :correlate, on: :collection
  end

  root :to => 'interests#index'
end
