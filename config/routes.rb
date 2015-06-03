Rails.application.routes.draw do
  devise_for :users

  resources :users do
    member do
      post :follow
      post :unfollow
      get :api_get_info
      get :api_get_messages
      get :api_get_followers
      get :api_get_following
    end
  end

  resources :messages

  root to: 'messages#new'
end