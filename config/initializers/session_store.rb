# config/initializers/session_store.rb
Rails.application.config.session_store :redis_store, servers: 'redis://localhost:6379/0/session',
                                                     key: '_steam_auth_app_session'
