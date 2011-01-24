class SessionsController < ApplicationController
  skip_before_filter :authenticate
  def create
    auth = request.env['rack.auth']
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    login! @auth.user

    render :text => "Welcome, #{current_user.name}."
  end
  
  def destroy
    logout!
    redirect_to root_path
  end
end