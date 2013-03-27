Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '151121558389056', '0b4c505fd2e2205f74d27d0f36f8d14f', :scope => 'user_events,friends_events', :display => 'popup'
end
