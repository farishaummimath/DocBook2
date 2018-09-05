# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_DocBook2_session',
  :secret      => '03332cb7859d9df26b31ddfbd5479a4490e2af5858336230aff76ac5478921cba8cd957a4d0171ad3cdf3e540f6076472d0122e091c781dbced3faa58ef5ac60'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
