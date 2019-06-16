module Api
  module V1
    module Requests
      module RestartingsDoc
        extend Apipie::DSL::Concern

        api :POST, '/v1/requests/:request_id/restarting', 'Restart failed request'

        header 'Authorization', 'Bearer authorization_id', required: true

        def create; end
      end
    end
  end
end
