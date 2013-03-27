class User < ActiveRecord::Base
  attr_accessible :email, :name, :provider, :uid, :user_id, :first_name

def self.create_with_omniauth(auth)
	create! do |user|
		user.provider = auth["provider"]
		user.uid = auth["uid"]
	#	user.fb_access_token = auth['credentials']['token']
        user.name = auth["info"]["name"]
        user.first_name = auth["info"]["first_name"]
    #   user.image = auth["info"]["image"]
    end
end

end
