class User < ActiveRecord::Base
  attr_accessible :email, :name, :provider, :uid, :user_id, :first_name


#for each user that comes through, fill in the following data.
#@param auth comes from the sessions_controller. Pulls all of the data in form of a hash. Organizes it here. 
def self.create_with_omniauth(auth)
	create! do |user|
		user.provider = auth["provider"]
		user.uid = auth["uid"]
		user.fb_access_token = auth['credentials']['token']
        user.name = auth["info"]["name"]
        user.first_name = auth["info"]["first_name"]
        user.user_image = auth["info"]["image"]
    end
end

end
