BallHockey::Application.routes.draw do 
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
      post :update_player_status
    end
  end
  
  resources :equipment
  resources :game_players
  
  get :login, :to => 'sessions#new'
  post :login, :to => 'sessions#create'
  delete :logout, :to => 'sessions#destroy'  
      
  root :to => "home#index"  
end


