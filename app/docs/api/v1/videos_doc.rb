module Api
  module V1
    module VideosDoc
      extend Apipie::DSL::Concern

      api :POST, '/v1/videos', 'Create trimmed video'

      header 'Authorization', 'Bearer authorization_id', required: true

      param :source_video, File, required: true

      def create; end
    end
  end
end
