Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '0g7zY1OfGPPpndDfomhCg', 'Hn7N05pcXx3rfO2AhDCF8762GEJWR83dJQDcAaN2TQI'
  provider :facebook, '89b2a0fcbf6b1cba3c7c49a2ad66aa1d', 'd15e841943d1c7f6769e77eabd70a1eag'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end