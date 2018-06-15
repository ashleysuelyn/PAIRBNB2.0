class SessionsController < Clearance::SessionsController

def create_from_omniauth
  auth_hash = request.env["omniauth.auth"] #save google account's data into this variable
  authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

  # if: previously already logged in with OAuth
  if authentication.user
    user = authentication.user
    # authentication.update_token(auth_hash)
    # @next = root_url #or root_path
    @notice = "Signed in!"
  # else: user logs in with OAuth for the first time
  else
    user = User.create_with_auth_and_hash(authentication, auth_hash)
    # you are expected to have a path that leads to a page for editing user details
    # @next = edit_user_path(user) #edit account
    @notice = "User created. Please confirm or edit details"
  end

  sign_in(user)
  redirect_to listings_path, :notice => @notice 
  #flash calls notice in views by flash[:notice] or loop notice by <% flash.each do |key, value| %><div class="flash <%= key %>"><%= value %></div>
end
end