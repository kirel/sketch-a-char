DetexifyRails::Application.routes.draw do
  
  # login/logout
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/login', to: 'sessions#new', as: :login
  match '/logout', to: 'sessions#destroy', as: :logout
  
  # api controller
  get "api/samples"
  get "api/symbols"

  # management
  resources :syms do
    resources :samples, only: [:index, :create, :destroy] do
      member do
        post :vote_up
        post :vote_down
      end
    end
  end
  
  # root
  match '/index.html', :to => "app#index"
  root :to => "app#index"
  
  match "/cache-manifest" => Rails::Offline.new {
    
    cache 'index.html'    
    
    files = Dir[
      "#{root}/**/*.html",
      "#{root}/stylesheets/**/*.css",
      "#{root}/javascripts/**/*.js",
      "#{root}/images/**/*.*"]

    files.each do |file|
      cache Pathname.new(file).relative_path_from(root)
    end

    cache 'api/samples.json'
    cache 'api/symbols.json'

    network "/"
  }
end
