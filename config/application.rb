require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jottings
  class Application < Rails::Application
    config.action_view.field_error_proc = ->(html_tag, instance) { html_tag }
  end
end
