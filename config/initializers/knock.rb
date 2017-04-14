Knock.setup do |config|

  ## Expiration claim
  ## ----------------
  ##
  ## How long before a token is expired. If nil is provided, token will
  ## last forever.
  ##
  ## Default:
  # config.token_lifetime = 1.day
  config.token_lifetime = 6.hours

  ## Audience claim
  ## --------------
  ##
  ## Configure the audience claim to identify the recipients that the token
  ## is intended for.
  ##
  ## Default:
  # config.token_audience = nil

  ## Signature algorithm
  ## -------------------
  ##
  ## Configure the algorithm used to encode the token
  ##
  ## Default:
  # config.token_signature_algorithm = 'HS256'

  ## Signature key
  ## -------------
  ##
  ## Configure the key used to sign tokens.
  ##
  ## Default:
  # config.token_secret_signature_key = -> { Rails.application.secrets.secret_key_base }

  ## Public key
  ## ----------
  ##
  ## Configure the public key used to decode tokens, if required.
  ##
  ## Default:
  # config.token_public_key = nil

  ## Exception Class
  ## ---------------
  ##
  ## Configure the exception to be used when user cannot be found.
  ##
  ## Default:
  # config.not_found_exception_class_name = 'ActiveRecord::RecordNotFound'
end

# Refresh token lifetime.
# How long before a token is expired
Rails.application.config.refresh_token_lifetime = 7.days
