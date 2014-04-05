source 'https://rubygems.org'

gem 'rails', '4.0.4'
gem 'sass-rails', '~> 4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'slim-rails'
#gem 'devise'
#gem 'omniauth-google-oauth2'
#gem 'cancancan', '~> 1.7'

group :development do
    gem 'sqlite3'
    gem 'guard'
    gem 'guard-bundler'
    gem 'guard-rails'
    gem 'guard-livereload'
    gem 'capistrano', '~> 3.0', require: false
    gem 'capistrano-rails', '~> 1.1', require: false
    gem 'capistrano-bundler', '~> 1.1', require: false
    gem 'capistrano-rvm', '~> 0.1', require: false
end

group :staging, :production do
    gem 'pg'
    gem 'unicorn'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
