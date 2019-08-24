Rails.application.routes.draw do
  resources :tags do
    collection do
      get :search
    end
  end
  resources :users
  resources :videos
  get 'sample' => 'welcome#index'
  get 'search' => 'tags#search'
  #
  # get 'tag/:keyword', to: 'tags#search'
  # post 'tag/:keyword', to: 'tags#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
