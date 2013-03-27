class SessionsController < ApplicationController
  
  #require 'koala'

  def new
  end

  def create
  auth_hash = request.env['omniauth.auth']
 # @authorization = User.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
 # if @authorization
    user = User.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || User.create_with_omniauth(auth_hash)
    session[:user_id] = user.id
    session['fb_auth'] = auth_hash
    session['fb_access_token'] = auth_hash['credentials']['token']
    session['fb_error'] = nil
    redirect_to '/', :notice => "Welcome back #{user.name}! You have already signed up."
end

def destroy
  session[:user_id] = nil
  session['fb_access_token'] = nil

  redirect_to '/', :notice => "You've logged out!"
end

def failure
  redirect_to '/', :notice => "Sorry, but you didn't allow access to our app!"
end

end
