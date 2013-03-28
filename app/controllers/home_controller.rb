class HomeController < ApplicationController
helper_method :picture
helper_method :try
helper_method :events
helper_method :log?

#helper_method allows me to use this method in views. There's probaby a better way to do this, but for right now it's a start.

def index
end

#if logged in, instantiate a new Koala client. This is Koala. @graph is our client. We shove parameters in and get facebook infromation out.
#we shoved in 'me' as the person to research (me defaults to current_user). get_picture method gets the profile pic of the user.

	if session["fb_access_token"].present?
		@graph = Koala::Facebook::API.new(session["fb_access_token"])
   		@profile_image = @graph.get_picture("me")
	end
end

#if logged in, once again make another Koala client that will pull information from Open graph about the user.
#get_connections is a broad method that gets a lot of the social information of a person (friends and other stuff). in this case we use it to grab 'events'
#@String stores a hash (sorry for the misnomer. Should change that soon) of all the events a user has responded to.
def events
	if session["fb_access_token"].present?
		@graph = Koala::Facebook::API.new(session["fb_access_token"])
		@string = @graph.get_connections("me", "events")
		#@events.class
		#@events.first
	end
end

#"{'eventslist':\'SELECT eid, rsvp_status FROM event_member WHERE uid = me() #AND start_time > " + Math.round(new Date().getTime() / 1000) + " ORDER BY start_time','eventsdetails':'SELECT eid, name, description, location, venue, creator, pic_square, start_time, end_time FROM event WHERE eid IN (SELECT eid FROM #eventslist) ORDER BY start_time'}";

#sees if someone is logged in
def log?
	session["fb_access_token"].present?
end

#named try because i was desperate
#third time we set up a Koala client. HOWEVER, this time we use it for an FQL query, not a Open Graph Query. Instead of doing graph.get_blank, we do fql.fql_query
#fql query is basically a different more encapsulating way of doing open graph
#I copied that code from someone online, but it basically checks the rsvp_status of each EID a person (UID) is a "part of," or event member which is really just invitations.
#pretty clever.
def try
	if session["fb_access_token"].present?
	@fql = Koala::Facebook::API.new(session["fb_access_token"])
	fql = @fql.fql_query("SELECT eid, rsvp_status FROM event_member WHERE uid = me()")
	end
end


end
