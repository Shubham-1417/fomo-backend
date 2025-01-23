require 'jwt'

class JsonWebToken
  # Define a secret key for encoding and decoding JWTs
  SECRET_KEY = Rails.application.credentials.secret_key_base || ENV['SECRET_KEY_BASE'] || 'your_fallback_secret_key'

  # Encode a payload into a JWT token, default expiration is 24 hours
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i # Add expiration time to the payload
    JWT.encode(payload, SECRET_KEY) # Encode the payload using the secret key
  end

  # Decode a JWT token, returning the decoded payload as a hash
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0] # Decode the token
    HashWithIndifferentAccess.new(decoded) # Convert to a hash with indifferent access
  rescue JWT::DecodeError
    nil # Return nil if decoding fails
  end
end
