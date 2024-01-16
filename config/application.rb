require_relative 'boot'

require 'rails/all'

# require_relative 'init_config'
CONFIG = {}
CONFIG['version'] = '0.0.1'
CONFIG['password-salt'] = 'kind_words_of_no'
CONFIG['storage_path'] = ''
CONFIG['flags'] = {
  show_helper_images: true
}
CONFIG['user_levels'] = {
  "Admin": 1 << 4,
  "Moderator": 1 << 3,
  "Member": 1 << 2,
  "Anonymous": 1 << 0
}
CONFIG['email_from'] = ENV['email_from'] || ''
CONFIG['server_host'] = ENV['server_host'] || 'localhost'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AbenteuerLeben
  class Application < Rails::Application
    require 'forticons'

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    config.i18n.default_locale = :de

    # Logger
    # config.logger = Logger.new(STDOUT)
    # config.log_level = :info
    # config.logger.formatter = proc do |severity, time, _progname, msg|
    #   "[#{time}]  (#{severity}) -- : #{msg}"
    # end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.eager_load_paths << Rails.root.join('lib')
  end
end
