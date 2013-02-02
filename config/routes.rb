Knowledgebase::Application.routes.draw do
  devise_for :users
  resources :users, except: [:show] do
    get :profile, on: :collection
  end

  root :to => 'home#index'
end
