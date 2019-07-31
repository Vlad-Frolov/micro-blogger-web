# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

# https://github.com/colszowka/simplecov
require 'simplecov'
SimpleCov.start 'rails' do
  add_group 'Models', %w[app/models app/validators]
  add_group 'Commands & Libs', %w[app/workers app/services app/libs app/commands]
  add_group "Jobs", 'app/jobs'
  add_group "Policies", 'app/policies'
end

require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
require 'policy_assertions'
Dir[Rails.root.join("test", "test_helpers", "**", "*.rb")].each { |f| require f }

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]

class ActiveSupport::TestCase
  ActiveRecord::Migration.maintain_test_schema!
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include AuthTestHelper
end
