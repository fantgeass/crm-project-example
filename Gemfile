source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.12'

gem 'mysql2'
gem 'state_machine' # state machine for tcp, project
gem 'userstamp', github: 'theepan/userstamp' # add userstamp to models
gem 'simple_form' # form generation helper
gem 'paperclip', '~> 3.0' # file attachment
gem 'annotate', '>=2.5.0' # model annotation with attributes
gem 'enumerize' # enum support
gem 'acts_as_commentable_with_threading'

gem 'inherited_resources' # DRY controllers
gem 'has_scope' # scope in controllers

gem 'draper', '~> 1.0' # representer
gem 'kaminari' # Pagination

gem 'devise', '>= 2.2.3' # authentification
gem 'cancan', '>= 1.6.8' # authorization
gem 'rolify'             # roles to auth

gem 'ffaker' # Generate Fake data
gem 'seed-fu' # Seed data

gem 'sorted', '~> 0.4.3' # sort data
#gem 'ransack' # search logic
gem 'pacecar' # scopes

gem 'russian', '~> 0.6.0'
gem 'navigasmic', github: 'jejacks0n/navigasmic' # navigation
gem 'client_side_validations'
gem 'client_side_validations-simple_form'
gem 'slim-rails' # html preprocessor
gem 'rabl' # json api
gem 'js-routes'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 2.2.2.0'
  gem 'skim' # html preprocessor for js side
  gem 'therubyracer' # if we dont have node.js
  gem 'compass-rails'
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'select2-rails', github: 'argerim/select2-rails' # chosen analog
  gem 'backbone-on-rails'
  gem 'jquery-fileupload-rails'
  gem 'turbo-sprockets-rails3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'fuubar' # rspec formatter
end

group :development do
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'thin' # web server
  gem 'quiet_assets'

  gem 'better_errors' # better error pages
  gem 'binding_of_caller'
  gem 'meta_request' # rails panel

  gem 'rack-livereload' # live reload scss

  # Guard
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-annotate'
  gem 'rb-inotify'
end

group :test do
  gem 'shoulda-matchers'
  gem 'zeus'
end