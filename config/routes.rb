Rails.application.routes.draw do
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
    resources :memo_room_posts, only: [:new, :create,]
  end
  resources :memo_room_posts, only: [:index, :show, :destroy, :edit, :update]
  resources :categories, only: [:index, :new, :create, :edit, :update]
end