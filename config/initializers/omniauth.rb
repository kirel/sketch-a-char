require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '0g7zY1OfGPPpndDfomhCg', 'Hn7N05pcXx3rfO2AhDCF8762GEJWR83dJQDcAaN2TQI'
  provider :facebook, '185398324838487', 'd15e841943d1c7f6769e77eabd70a1eagst', scope: ''
  provider :open_id, OpenID::Store::Filesystem.new('./tmp')  
end