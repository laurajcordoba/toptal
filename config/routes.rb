Toptal::Application.routes.draw do
  authenticated :user do
    root :to => 'tasks#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :tasks, except: [:show] do
    put :toggle, on: :member
  end

  namespace :api do
    resources :tasks
  end

end
