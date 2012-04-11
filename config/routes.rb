Correlate::Application.routes.draw do
  devise_for :users

  root :to => 'interests#index'
end
