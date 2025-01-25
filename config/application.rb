require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Forum
  class Application < Rails::Application
    # Initialize configuration defaults for Rails 8.0
    config.load_defaults 8.0

    # Set the application to API-only mode
    config.api_only = true

    # Autoload paths for lib directory 
    config.autoload_paths += %W(#{config.root}/lib)

    # Enable CORS for cross-origin requests
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*' 
        resource '*',
                 headers: :any,
                 methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
  end
end
