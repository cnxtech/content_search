server 'sul-contentsearch-uat.stanford.edu', user: 'content_search', roles: %w(web app)

Capistrano::OneTimeKey.generate_one_time_key!
set :rails_env, 'production'
