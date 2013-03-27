class HomeController < ApplicationController
def index
end

def picture
	if session["fb_access_token"].present?
		@graph = Koala::Facebook::API.new(session["fb_access_token"])
   		@profile_image = @graph.get_picture("me")
	end
end

def events
	if session["fb_access_token"].present?
		@graph = Koala::Facebook::API.new(session["fb_access_token"])
		@string = @graph.get_connections("me", "events")
		#@events.class
		#@events.first
	end
end

#"{'eventslist':\'SELECT eid, rsvp_status FROM event_member WHERE uid = me() #AND start_time > " + Math.round(new Date().getTime() / 1000) + " ORDER BY start_time','eventsdetails':'SELECT eid, name, description, location, venue, creator, pic_square, start_time, end_time FROM event WHERE eid IN (SELECT eid FROM #eventslist) ORDER BY start_time'}";

def log?
	session["fb_access_token"].present?
end

def try
	if session["fb_access_token"].present?
	@fql = Koala::Facebook::API.new(session["fb_access_token"])
	fql = @fql.fql_query("SELECT eid, rsvp_status FROM event_member WHERE uid = me()")
	end
end


end
