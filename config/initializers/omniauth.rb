require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_APP_ID'], ENV['TWITTER_APP_SECRET'] if ENV['TWITTER_APP_ID']
  provider :facebook, ENV['FB_APP_ID'], ENV['FB_APP_SECRET'], scope: '' if ENV['FB_APP_ID']
  provider :open_id, OpenID::Store::Filesystem.new('./tmp')
end
