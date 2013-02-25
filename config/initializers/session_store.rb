Space::Application.config.session_store :active_record_store, 
  :key => '_Space_session', 
  :domain => Rails.env.production? ? '.space-a.fr' : '.space-a.local'
