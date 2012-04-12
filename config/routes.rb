Correlate::Application.routes.draw do
  devise_for :users
  resources :interests, only: [:index, :create, :update] do
    post :correlate, on: :collection
  end

  root :to => 'interests#index'
end
