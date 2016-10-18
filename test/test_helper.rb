ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'clearance/test_unit'
require 'capybara/rails'
require 'capybara/poltergeist'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  self.use_transactional_tests = false
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.current_driver = :poltergeist
    Capybara.default_max_wait_time = 5
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
