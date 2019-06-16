module Api
  module V1
    module Requests
      class RestartingsController < UserAuthenticationController
        include ::Api::V1::Requests::RestartingsDoc

        def create
          run ::Request::Restart

          head :created
        end
      end
    end
  end
end
