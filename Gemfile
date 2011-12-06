source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'thin'
gem 'foreman'

gem "jquery-rails"

gem "omniauth-openid"
gem 'omniauth-twitter'
gem 'omniauth-facebook'

gem "friendly_id"
gem "thumbs_up"
gem "haml-rails"
gem 'formtastic', '~> 2.0.0'
gem "kaminari"
gem "cancan"

gem 'dragonfly', '~>0.9.8'

gem "rack-offline"

group :production do
  gem 'pg'
  gem 'fog'
end

group :test, :development do
  gem "rspec-rails"
  gem 'sqlite3-ruby'
  gem 'heroku'
  gem 'rack-cache', :require => 'rack/cache'
end

group :test do
  gem "factory_girl_rails"
  gem "syntax"
end

group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end
