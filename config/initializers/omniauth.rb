Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '357084677734332', 'f6074bb95a3b5fb30ddce461bdc7ec91', :scope => 'user_events,friends_events', :display => 'popup'
end
