Markcase::Application.routes.draw do


  match '/' => 'application#index', :as => 'root'
  match '/home' => 'users#home', :as => 'home'
  match '/home/tag/:tag' => 'users#home', :as => 'home_tag'
  match '/reset_password' => 'settings#reset_password', :as => 'reset_password'

  resources :sessions
  resources :users
  resources :settings 
  resources :password_resets
  resources :tags
  resources :bookmarks do 
    collection  do 
      get 'multiple'
      get 'description'
    end
  end
  resources :categories
  
  #admin namespace route
  match 'admin/login' => 'admin::sessions#new', :as => 'admin_login'
  match 'admin/logout' => 'admin::sessions#destroy', :as => 'admin_logout'
  namespace :admin do 
    resources :users do 
      resources :categories
      collection do 
        get 'get_bookmarks/:user_id' => 'users#get_bookmarks', :as => 'get'
        get 'get_categories/:user_id' => 'users#get_categories', :as => 'get'
      end
    end
    #resources :categories 
    resources :bookmarks do 
      collection do 
        get 'tags/:tag' => 'bookmarks#tags', :as => 'tags'
        get 'tag'
      end
    end
    resources :sessions, :only => ['create']
  end
end
