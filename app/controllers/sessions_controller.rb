class SessionsController < ApplicationController
  skip_before_filter :authenticate
  def create
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    login! @auth.user

    redirect_to root_path
  end
  
  def destroy
    logout!
    redirect_to root_path
  end
  
  def fail
    flash[:error] = 'Hat nicht geklappt.'
    redirect_to root_path
  end
end