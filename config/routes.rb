Knowledgebase::Application.routes.draw do
  devise_for :users

  resources :users, except: [:show] do
    get :profile, on: :collection
  end

  resources :skills do
    resources :questions
  end

  root :to => 'home#index'
end
