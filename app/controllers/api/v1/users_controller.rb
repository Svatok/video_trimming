module Api
  module V1
    class UsersController < ::Api::V1::BaseController
      include ::Api::V1::UsersDoc

      def create
        result = run User::Create

        render json: result[:serialized_model].to_json
      end
    end
  end
end
