# Be sure to restart your server when you modify this file.

# Classic session store
# Space::Application.config.session_store :cookie_store, key: '_Space_session', domain: ".space.local"

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Space::Application.config.session_store :active_record_store

Space::Application.config.session_store :active_record_store, key: '_Space_session', domain: ".space.local"
