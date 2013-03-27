class SessionsController < ApplicationController
  
  require 'koala'

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    #gets a hash of all the data of a user from loggin in. The parameter omniauth.auth is taken from our login omniauth gem.
    
    user = User.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || User.create_with_omniauth(auth_hash)
    #The user will either be a user from our database, sorted by provider and their UID OR we will create one with omniauth information. (create_with is in User model)
    
    session[:user_id] = user.id
    session['fb_auth'] = auth_hash
    session['fb_access_token'] = auth_hash['credentials']['token']
    #set userID, auth information and access token for this session. This is using Koala gem.

    session['fb_error'] = nil
    #don't do shit if fb throws an error.

    redirect_to '/', :notice => "Welcome back #{user.name}! You have already signed up."
    #redirect to root index. Display message. user.name pulls from user model.
end

def destroy
  session[:user_id] = nil
  session['fb_access_token'] = nil
  #throw out fb access token and uid from system.

  redirect_to '/', :notice => "You've logged out!"
end

def failure
  redirect_to '/', :notice => "Sorry, but you didn't allow access to our app!"
end

end
