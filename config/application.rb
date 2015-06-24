require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)

# Config loading
SIMPTTER_CONFIG = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'simptter.yml'))

module Simptter
  class Application < Rails::Application
    config.active_support.escape_html_entities_in_json = true
    # I18n
    config.i18n.default_locale = SIMPTTER_CONFIG['locale']['default']
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*_*', '*.yml')]
    config.encoding = 'utf-8'
    I18n.config.enforce_available_locales = false
    # Assets
    config.assets.enabled = true
    config.assets.initialize_on_precompile = false
    config.assets.version = '1.0'
    config.assets.logger = nil
    config.assets.precompile << /(^[^_\/]|\/[^_])[^\/]*$/
  end
end