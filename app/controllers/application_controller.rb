class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  #@current user, it's either false, I.E. no one is signed in. Or it equals the current user if one is signed in. Variable in Ruby apparently don't give two fucks about being typecasted, so it can be false or a number. Weird
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
	rescue ActiveRecord::RecordNotFound 
 end
  
end
