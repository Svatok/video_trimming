module Api
  module V1
    class RequestsController < UserAuthenticationController
      include ::Api::V1::RequestsDoc

      def index
        result = run Request::Index

        render json: result[:serialized_model].to_json
      end
    end
  end
end
