module CookieInspector
  class Engine < ::Rails::Engine
    isolate_namespace CookieInspector

    config.cookie_inspector = ActiveSupport::OrderedOptions.new

    config.cookie_inspector.secret_key_base = nil

    initializer 'cookie_inspector.helpers.secret_key_base' do |app|
      CookieInspectorHelper.secret_key_base = app.config.cookie_inspector.secret_key_base
    end

  end
end
