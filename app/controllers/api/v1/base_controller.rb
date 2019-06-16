module Api
  module V1
    class BaseController < ::ApplicationController
      include ::Authenticable::User
      include Trailblazer::Rails::Controller

      private

      def render_json_api_errors(result, status:)
        render jsonapi_errors: result['contract.default']&.errors,
               class: { 'Reform::Contract::Errors': Lib::Representer::ReformErrorsSerializer },
               status: status
      end
    end
  end
end
