Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '0g7zY1OfGPPpndDfomhCg', 'Hn7N05pcXx3rfO2AhDCF8762GEJWR83dJQDcAaN2TQI'
  # provider :facebook, 'APP_ID', 'APP_SECRET'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end