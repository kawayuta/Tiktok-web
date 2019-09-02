Rails.application.routes.draw do
  resources :tag_histories
  mount_roboto
  root to: 'welcome#index'
  resources :tags, only: :show do
    collection do
      get :search
    end
    member do
      get :ranking
    end
  end
  resources :users, only: :show
  # resources :videos
  #
  # get 'tag/:keyword', to: 'tags#search'
  # post 'tag/:keyword', to: 'tags#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
