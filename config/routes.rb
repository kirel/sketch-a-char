DetexifyRails::Application.routes.draw do
  
  resources :representations

  # login/logout
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/login', to: 'sessions#new', as: :login
  match '/logout', to: 'sessions#destroy', as: :logout
  
  # management
  resources :syms do
    resources :representations
    resources :latex_representations,   controller: :representations
    resources :unicode_representations, controller: :representations
    resources :samples, only: [:index, :create, :destroy] do
      member do
        post :vote_up
        post :vote_down
      end
    end
  end
  
  # root
  match '/index', :to => "app#index", as: 'app'
  root :to => "app#index"
  
  # match "/cache-manifest" => Rails::Offline.new {
  #   
  #   cache 'index.html'    
  #   
  #   files = Dir[
  #     "#{root}/**/*.html",
  #     "#{root}/stylesheets/**/*.css",
  #     "#{root}/javascripts/**/*.js",
  #     "#{root}/images/**/*.*"]
  # 
  #   files.each do |file|
  #     cache Pathname.new(file).relative_path_from(root)
  #   end
  # 
  #   cache 'api/samples.json'
  #   cache 'api/symbols.json'
  # 
  #   network "/"
  # }
end
