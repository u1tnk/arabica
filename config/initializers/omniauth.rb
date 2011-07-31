Rails.application.config.middleware.use OmniAuth::Builder do
  #twitter , consumer, consumer_secret
  provider :twitter, ENV['ARABICA_CONSUMER'], ENV['ARABICA_CONSUMER_SECRET']
end
