Rails.application.routes.draw do
  devise_for :users

  resources :users do
    member do
      post :follow
      post :unfollow
    end
  end
  %w(get_info get_messages get_followers get_following).each do |api_method|
    get "/users/api/:id/#{api_method}" => "users#api_#{api_method}"
    post "/users/api/:id/#{api_method}" => "users#api_#{api_method}"
  end

  resources :messages

  root to: 'messages#new'
end