source 'http://rubygems.org'

gem "rails", "~> 3.2.15"
gem 'thin'
gem 'foreman'
gem "airbrake"

gem "jquery-rails"
gem 'jquery-ui-rails'
gem 'glow'

gem "omniauth-openid"
gem 'omniauth-twitter'
gem 'omniauth-facebook'

gem "friendly_id", "~> 4.0.10"
gem "thumbs_up"
gem "haml-rails"
gem 'simple_form'
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
  gem 'rack-cache', :require => 'rack/cache'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem "factory_girl_rails"
  gem "syntax"
end

group :assets do
  gem 'uglifier'
  gem 'sass-rails', "  ~> 3.2.0"
  gem 'coffee-rails', "~> 3.2.0"
  gem 'compass-rails'
  gem 'zurb-foundation', '~> 4.3.2'
end
