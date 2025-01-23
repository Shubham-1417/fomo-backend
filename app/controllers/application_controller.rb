class ApplicationController < ActionController::Base
 protect_from_forgery with: :null_session

 # Allow access to the helper method in controllers and views
 helper_method :current_user

 # Authenticate user before any action, unless overridden
 before_action :authenticate_request

 private

 # Retrieve the current user based on the token
 def current_user
   @current_user ||= begin
     decoded_token = JsonWebToken.decode(auth_token)
     User.find_by(id: decoded_token[:user_id]) if decoded_token
   end
 rescue StandardError
   nil
 end

 # Authenticate the request using the token
 def authenticate_request
  header = request.headers['Authorization']
  logger.debug "Authorization Header: #{header}" # Log the header
  header = header.split(' ').last if header
  decoded = JsonWebToken.decode(header)
  logger.debug "Decoded Token: #{decoded}" # Log the decoded token
  @current_user = User.find(decoded[:user_id]) if decoded
rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
  logger.debug "Authentication Error: #{e.message}" # Log any errors
  render json: { error: 'Unauthorized' }, status: :unauthorized
end

 # Extract the token from the Authorization header
 def auth_token
   if request.headers['Authorization'].present?
     request.headers['Authorization'].split(' ').last
   else
     nil
   end
 end
end