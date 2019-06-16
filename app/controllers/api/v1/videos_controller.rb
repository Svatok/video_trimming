module Api
  module V1
    class VideosController < UserAuthenticationController
      include ::Api::V1::VideosDoc

      def index
        result = run Video::Index

        render json: result[:serialized_model].to_json
      end

      def create
        result = run ::Video::Create

        if result.success?
          head :created
        else
          render_json_api_errors(result, status: :unprocessable_entity)
        end
      end
    end
  end
end
