Rails.application.routes.draw do
  get 'memo_room_posts/create'
  get 'memo_room_posts/destroy'
  get 'memo_room_posts/edit'
  get 'relationships/create'
  get 'relationships/destroy'
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :memo_room_posts, only: [:index, :show, :new, :create, :destroy, :edit, :update]
end