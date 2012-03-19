Nrcanhockey::Application.routes.draw do 
  resources :players do
    collection do
      get :summary
      get :on_deck
    end
  end
  
  resources :games do
    collection do
      get :current
    end
  end
  
  resources :equipment
  
  get :login, :to => 'sessions#new'
  post :login, :to => 'sessions#create'
  delete :logout, :to => 'sessions#destroy'  
      
  root :to => "home#index"  
end


