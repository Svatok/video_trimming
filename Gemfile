source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# System
gem 'bootsnap', require: false
gem 'mongoid'
gem 'puma'
gem 'rack-cors'
gem 'rails'
gem 'tzinfo-data'

# Trailblazer bundle
gem 'dry-types'
gem 'dry-validation', '0.11.1'
gem 'trailblazer-rails'

# Serializer
gem 'jsonapi-rails'

# API documentation generator
gem 'apipie-rails'

# Video processing
gem 'streamio-ffmpeg'

# Video storage
gem 'aws-sdk-s3'
gem 'shrine-mongoid'

# Background processing
gem 'sidekiq'

group :development, :test do
  gem 'awesome_print'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'bullet'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'json-schema'
  gem 'mongoid-rspec'
  gem 'pronto', require: false
  gem 'pronto-brakeman', require: false
  gem 'pronto-fasterer', require: false
  gem 'pronto-rails_best_practices', require: false
  gem 'pronto-rails_schema', require: false
  gem 'pronto-rubocop', require: false
  gem 'shrine-memory'
  gem 'simplecov', require: false
end
