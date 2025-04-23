require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CodespacesTryRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1
    config.paths.add 'frontend/views', eager_load: true
    config.paths.add 'frontend/assets', eager_load: true
    config.paths.add 'backend/controllers', eager_load: true
    config.paths.add 'backend/models', eager_load: true
    config.paths.add 'backend/services', eager_load: true
    config.paths.add 'backend/lib', eager_load: true

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
     
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*' # Erlaubt Anfragen von allen Domains (nur für Entwicklung)
        resource '*',
                 headers: :any,
                 methods: %i[get post put patch delete options head]
      end
    end

  end
end
