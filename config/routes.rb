require 'resque/server'

BallHockey::Application.routes.draw do 
  mount Resque::Server.new, :at => "/resque"
  
  resources :players do
    collection do
      get :summary
      get :on_deck
      get :search
    end
  end
  
  resources :games do
    collection do
      get :current
      get :no_current_game
    end
    member do
      get :player_status
      put :update_player_status
    end
  end
  
  resources :equipment
  resources :game_players
  
  get :login, :to => 'sessions#new'
  post :login, :to => 'sessions#create'
  delete :logout, :to => 'sessions#destroy'  
      
  # webhooks
  post 'sendgrid_notify' => 'web_hooks#sendgrid_notify'      
      
  root :to => "home#index"  
end


