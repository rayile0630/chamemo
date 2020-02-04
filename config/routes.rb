Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  post 'categories/create'
  get 'categories/destroy'
  get 'memo_rooms/create'
  get 'memo_rooms/destroy'
  get 'memo_rooms/edit'
  get 'memo_rooms/update'
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
   resources :memo_rooms, only: [:index, :new, :show, :create, :edit, :update, :destroy] do
     collection do
      get :search
    end
    resources :memo_room_posts, only: [:index, :new, :create]
    resources :memo_room_comments, only: [:index, :new, :create, :destroy]
  end
  resources :memo_room_posts, only: [:show, :destroy, :edit, :update]
  resources :categories, only: [:index, :new, :create, :edit, :update]
  resources :favorites, only: [:create, :destroy]
  resources :memo_room_comments, only: [:index, :show]
end