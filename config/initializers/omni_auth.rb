Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :github,
    Rails.application.config.twinkle.github.client_id,
    Rails.application.config.twinkle.github.client_secret,
    scope: 'user:email,repo'
  )
end
