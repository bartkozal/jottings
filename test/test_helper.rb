ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/mock'
require 'clearance/test_unit'
require 'capybara/rails'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  self.use_transactional_tests = false
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
    DatabaseRewinder.clean
  end

  def use_js
    Capybara.current_driver = :selenium
  end
end
