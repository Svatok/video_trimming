Apipie.configure do |config|
  config.app_name                = 'VideoTrimming'
  config.api_base_url            = '/api'
  config.doc_base_url            = '/apipie'
  config.namespaced_resources    = true
  config.default_version         = 'v1'
  config.translate               = false
  config.validate                = false
  config.show_all_examples       = true
  config.default_locale          = nil
  config.api_routes              = Rails.application.routes
  config.api_controllers_matcher = Rails.root.join('app', 'controllers', 'api', 'v1', '**', '*.rb')
end

# This monkey patch saves our eyes from bleeding https://github.com/Apipie/apipie-rails/issues/455
# rubocop:disable all
module Apipie
  class Application
    def get_resource_name(klass)
      if klass.class == String
        klass
      elsif @controller_to_resource_id.has_key?(klass)
        @controller_to_resource_id[klass]
      elsif Apipie.configuration.namespaced_resources? && klass.respond_to?(:controller_path)
        return nil if klass == ActionController::Base
        path = klass.controller_path
        path.gsub(version_prefix(klass), " -> ").tr("/", "-")
      elsif klass.respond_to?(:controller_name)
        return nil if klass == ActionController::Base
        klass.controller_name
      else
        raise "Apipie: Can not resolve resource #{klass} name."
      end
    end
  end
end
# rubocop:enable all
