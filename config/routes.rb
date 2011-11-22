NextStep::Application.routes.draw do 
  resources :users  
  resources :sessions,  :only => [:new, :create, :destroy]
  resources :projects do 
    resources :steps
  end

  root :to => "sessions#new"

  match '/about',     :to => 'pages#about'
  match '/contact',   :to => 'pages#contact'
  match '/signup',    :to => 'users#new' 
  match '/signin',    :to => 'sessions#new'
  match '/signout',   :to => 'sessions#destroy'
  match '/todo',      :to => 'projects#todo'
end
