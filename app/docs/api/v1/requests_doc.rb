module Api
  module V1
    module RequestsDoc
      extend Apipie::DSL::Concern

      api :GET, '/v1/requests', 'Show all requests'

      header 'Authorization', 'Bearer authorization_id', required: true

      def index; end
    end
  end
end
