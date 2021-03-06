require 'spec_helper'

require 'simplecov'
SimpleCov.minimum_coverage(100)
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'mongoid-rspec'
require 'support/matchers/match_schema'
require 'support/helpers'

RSpec.configure do |config|
  # Sync FFaker random values with Rspec seed option (to capture random failing tests).
  config.before(:all)  { FFaker::Random.seed = config.seed }
  config.before(:each) { FFaker::Random.reset! }

  config.include FactoryBot::Syntax::Methods
  config.include Mongoid::Matchers, type: :model
  config.include Helpers

  # Clean/Reset Mongoid DB prior to running each test.
  config.before(:each) do
    Mongoid.default_client.collections.reject { |c| c.name =~ /system/ }.each(&:drop)
  end

  config.after(:each) do
    ActiveJob::Base.queue_adapter.enqueued_jobs = []
    ActiveJob::Base.queue_adapter.performed_jobs = []
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # To generate apipie examples use APIPIE_RECORD=examples rspec spec/controllers
  config.filter_run show_in_doc: true if ENV['APIPIE_RECORD']
end

RSpec::Matchers.define_negated_matcher :not_change, :change
